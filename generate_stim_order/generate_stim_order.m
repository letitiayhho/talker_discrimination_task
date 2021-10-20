    function [stim_order, same_key, n_trials, block_type]  = generate_stim_order(subject_number, block)
    addpath('generate_stim_order/functions')

    % SET SEED
    rng(subject_number)
    
    % Get same key
    same_key = get_same_key();
    
    % SET SEED for different blocks
    seed = str2double(strcat(num2str(subject_number), num2str(block)));
    rng(seed)

    % Get talker order
    [talker1, talker2, same, key, n_trials, same_key, block_type] = get_talker_order(block, same_key);

    % Get vowel order
    [vowel1, vowel2] = get_vowel_order(block);
    
    % Get exemplar order
    exemplar1 = get_exemplar_order(n_trials);
    exemplar2 = get_exemplar_order(n_trials);

    % Get block number
    block = repmat(block, n_trials, 1);
    rep = (1:n_trials)';

    % Add subject number
    subject = repmat(subject_number, n_trials, 1);

    % CREATE TABLE
    stim_order = table(subject, block, rep, vowel1, vowel2, exemplar1,...
        exemplar2, talker1, talker2, same, key);
end
