function [vowel1, vowel2] = get_vowel_order(block)
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
        
        if block == 1 % if training
            % get 6 mismatched pairs for training trials
            vowel_order = datasample(vowel_order, 6, 'Replace', false);
            
            % get 6 matched pairs
            vowel_order = [vowel_order; repmat(possible_vowels, 2)'];
            vowel_order = [vowel_order; datasample(repmat(possible_vowels, 2, 1)', 2)];

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
        
        % Check that for 3 pairs a vowel doesn't appear more than 4 times
        if check_repeats(vowel_order)
            break
        end
%         flattened_order = flatten(vowel_order);
%         if check_repeats(flattened_order)
%             break
%         end
    end

    vowel1 = vowel_order(:, 1);
    vowel2 = vowel_order(:, 2);
end

function flattened_seq = flatten(seq)
    flattened_seq = [];
    for i = 1:length(seq)
        flattened_seq = [flattened_seq; seq(i, :)'];
    end
end

% function break_loop = check_repeats(seq)
%     for j = 1:length(seq)-8
%         window = j:j+8;
%         counts = groupcounts(seq(window));
%         % Make sure that out of 9 doesn't appear more than 4 times
%         if sum(counts > 5) > 0
%             break_loop = false;
%             return
%         end
%     end
%     break_loop = true;
% end

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
        break_loop = true;
    end
end