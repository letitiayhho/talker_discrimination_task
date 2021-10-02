function stim_order = generate_stim_order(subject_number, BLOCK)
    cd '/Users/letitiaho/src/talker_discrimination_task/generate_stim_order/'
    addpath('functions')
    subject_number = str2num(subject_number);

    % SET SEED
    rng(subject_number)

    % Get talker order
    [talker1, talker2, same, key, n_trials] = get_talker_order(BLOCK);

    % Get vowel order
    vowel = get_vowel_order(n_trials);
    
    % Get exemplar order
    exemplar1 = get_exemplar_order(n_trials);
    exemplar2 = get_exemplar_order(n_trials);

    % Get block number
    block = repmat(BLOCK, n_trials, 1);
    rep = (1:n_trials)';

    % Add subject number
    subject = repmat(subject_number, n_trials, 1);

    % CREATE TABLE
    stim_order = table(subject, block, rep, vowel, exemplar1, exemplar2,...
        talker1, talker2, same, key);

    % WRITE
%     writetable(stim_order, ['output/', num2str(subject_number),
%     '_stim_order.txt']) % DONT WRITE, BUT USE TO TEST
end
