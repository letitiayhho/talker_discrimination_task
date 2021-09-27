function generate_stim_order(subject_number)
    cd '/Users/letitiaho/src/talker_discrimination_task/generate_stim_order/'
    addpath('functions')
    subject_number = str2num(subject_number);

    % SET SEED
    rng(subject_number)

    % Get talker order
    [talker1, talker2] = get_talker_order();

    % Get vowel order
    [vowel] = get_vowel_order();

    % Block 
    block_number = [1, 2, 3, 4, 5, 6];
    block_length = [8, 48, 48, 48, 48, 48];
    block = [];
    for i = 1:length(block_length)
        block = [block; repmat(block_number(i), block_length(i), 1)];
    end

    % Subject
    subject = repmat(subject_number, length(block), 1);

    % COLUMNS: subject, block, type, rep, utterance, vowel, istarget, talker
    stim_order = table(subject, block, vowel, talker1, talker2);

    % WRITE
    writetable(stim_order, ['output/', num2str(subject_number), '_stim_order.txt'])
end