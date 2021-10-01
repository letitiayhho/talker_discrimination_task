function generate_stim_order(subject_number)
    cd '/Users/letitiaho/src/talker_discrimination_task/generate_stim_order/'
    addpath('functions')
    subject_number = str2num(subject_number);

    % SET SEED
    rng(subject_number)

    % Get talker order
    [talker1, talker2, same] = get_talker_order();

    % Get vowel order
    vowel = get_vowel_order();
    
    % Get exemplar order
    exemplar1 = get_exemplar_order();
    exemplar2 = get_exemplar_order();

    % Get block number
    block_number = [1, 2, 3, 4, 5, 6];
    block_length = [8, 48, 48, 48, 48, 48];
    block = [];
    rep = [];
    for i = 1:length(block_length)
        block = [block; repmat(block_number(i), block_length(i), 1)];
        rep = [rep; (1:block_length(i))'];
    end

    % Add subject number
    subject = repmat(subject_number, length(block), 1);

    % CREATE TABLE
    stim_order = table(subject, block, rep, vowel, exemplar1, exemplar2,...
        talker1, talker2, same);

    % WRITE
    writetable(stim_order, ['output/', num2str(subject_number), '_stim_order.txt'])
end
