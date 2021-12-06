function generate_all_stim_orders()
%%
%  Generate a stim order for all groups and write into a single .js file
%%
    all_stim_orders = table();
    for group_number = 0:9
        fprintf(1, ['Stim order for group ', num2str(group_number), '\n'])
        group_stim_order = generate_stim_order(group_number);
        all_stim_orders = [all_stim_orders; group_stim_order];
    end
    
    % Write to JSON
    encodedjson = jsonencode(all_stim_orders);
    filename = fullfile('web', 'stim_order.js');    
    fid = fopen(filename, 'w');
    fprintf(fid, "const stim_order = ")
    fprintf(fid, encodedjson); 
    
    fprintf(1, "Donedidit\n")
    
    quit
    
    function group_stim_order = generate_stim_order(group_number)
    %%
    %  Feed in the first digit that appears in the subjectid
    %  randomly generated by jsPsych script and use it to 
    %  retrieve a stimulus order
    %%

        % SET SEED
        rng(group_number)

        % Get same key
        same_key = get_same_key(group_number);

        % Get block order
        [vowel_space, n_trials] = get_block_type(); 

        % Get stim order for each block
        group_stim_order = table();
        for block = 1:length(vowel_space)
            block_vowel_space = vowel_space(block);
            block_n_trials = n_trials(block);

            % Get talker order
            [talker1, talker2, same, key] = get_talker_order(same_key, block_vowel_space, block_n_trials);

            % Get vowel order
            [vowel1, vowel2] = get_vowel_order(block_vowel_space);

            % Get exemplar order
            exemplar1 = get_exemplar_order(block_n_trials);
            exemplar2 = get_exemplar_order(block_n_trials);

            % Get stim paths
            path1 = get_stim_path(talker1, vowel1, exemplar1);
            path2 = get_stim_path(talker2, vowel2, exemplar2);

            % Get block number
            block_number = repmat(block, block_n_trials, 1);
            block_vowel_space = repmat(block_vowel_space, block_n_trials, 1);
            rep = (1:block_n_trials)';

            % Create table
            block_stim_order = table(block_number, block_vowel_space, rep,...
                vowel1, vowel2, exemplar1, exemplar2, talker1, talker2,...
                path1, path2, same, key);

            % Append to overall stim order
            group_stim_order = [group_stim_order; block_stim_order];
        end

        % Add group number
        group = repmat(group_number, height(group_stim_order), 1);
        group_stim_order = [table(group), group_stim_order];
    end
end
