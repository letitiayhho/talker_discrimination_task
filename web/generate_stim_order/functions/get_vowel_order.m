function [vowel1, vowel2] = get_vowel_order(block_vowel_space)
    possible_vowels = ["AA", "EH", "IH", "OO"];

    while true
        % create all the mismatched pairs
        vowel_order = [];
        for i = possible_vowels
            for j = possible_vowels
                if i == j
                    continue
                end
                vowel_order = [vowel_order; i, j];
            end
        end
        
        if strcmp(block_vowel_space, "training") % if training
            % get 8 mismatched pairs for training trials
            vowel_order = datasample(vowel_order, 8, 'Replace', false);
            
            % get 8 matched pairs
            vowel_order = [vowel_order; repmat(possible_vowels, 2, 2)'];

            % randomize the order
            vowel_order = vowel_order(randperm(length(vowel_order)), :);
            
        else
            % double number of mismatched pairs to get 24
            vowel_order = [vowel_order; vowel_order]; 
            
            % add 24 matched pairs
            vowel_order = [vowel_order; repmat(possible_vowels, 2, 6)'];
        
            % randomize the order
            vowel_order = vowel_order(randperm(length(vowel_order)), :);
        end
        
        vowel1 = vowel_order(:, 1);
        vowel2 = vowel_order(:, 2);
        
        % Check that for 3 pairs a vowel doesn't appear more than 4 times
        if check_repeat_pairs(vowel_order) &&...
                check_repeat_places(vowel1) &&...
                check_repeat_places(vowel2)
            break
        end
    end


end

function break_loop = check_repeat_pairs(seq)
    for i = 1:length(seq)-1
        row = seq(i, :);
        next_row = seq(i+1, :);
        if row == next_row
            break_loop = false;
            return
        end
    end
    break_loop = true;
end

function break_loop = check_repeat_places(seq)
    for i = 1:length(seq)-3
        window = i:i+3;
        counts = groupcounts(seq(window));
        if sum(counts == 4) > 0
            break_loop = false;
            return
        end
    end
    break_loop = true;
end