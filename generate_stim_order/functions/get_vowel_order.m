function [vowel1, vowel2] = get_vowel_order(block, n_trials)
    possible_vowels = ["AA", "EH", "IH", "OO"];

    while true
        % Come up with a random vowel order
        vowel_order = [];
        for i = 1:n_trials
            vowel_order = [vowel_order; datasample(possible_vowels, 2, 'Replace', false)];
        end
        vowel1 = vowel_order(:, 1);
        vowel2 = vowel_order(:, 2);
        
        % Make sure count of each vowel is min 1 max 2 for training blocks
        if block == 1 &&...
            check_counts(vowel1, 1, 3) &&...
            check_counts(vowel2, 1, 3)
            return
        end
    
        % Make sure count of each vowel is min 8 max 12 for test blocks
        if block ~= 1 &&...
            check_counts(vowel1, 8, 12) &&...
            check_counts(vowel2, 8, 12)
            return
        end  
    end
    
    function break_loop = check_counts(seq, min, max)        
        counts = groupcounts(seq);
        
        % Make sure there is one sample of each vowel
        if length(counts) < 4
            break_loop = false;
            return
        end

        % Make sure each vowel appears at least a certain number of times
        if sum(counts < min) == 0 || sum(counts > max) == 0
            break_loop = true;
        else
            break_loop = false;
        end
    end
end
