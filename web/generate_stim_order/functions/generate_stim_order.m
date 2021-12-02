function generate_stim_order(group_number)
%%
%  Feed in the first digit that appears in the subjectid
%  randomly generated by jsPsych script and use it to 
%  retrieve a stimulus order
%%

    % SET SEED
    rng(str2double(group_number))
    
    % Get same key
    same_key = get_same_key();
    
    % Get block order
    [vowel_space, n_trials] = get_block_type(); 

    % Get stim order for each block
    stim_order = table();
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
        stim_order = [stim_order; block_stim_order];
    end
    
    % Add group number
    group = repmat(group_number, height(stim_order), 1);
    stim_order = [table(group), stim_order];
    
    % Write to JSON
    encodedjson = jsonencode(stim_order);
    filename = fullfile('web', 'generate_stim_order', 'stim_order', [char(group_number), '.json']);    
    fid = fopen(filename, 'w');
    fprintf(fid, encodedjson); 
    
    fprintf(1, "Done")
end