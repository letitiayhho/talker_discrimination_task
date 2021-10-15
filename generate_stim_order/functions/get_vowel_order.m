function [vowel1, vowel2] = get_vowel_order(n_trials)
    possible_vowels = ["AA", "EH", "IH", "OO"];

    while true
        % Come up with a random vowel order
        vowel_order = [];
        for i = 1:n_trials
            vowel_order = [vowel_order; datasample(possible_vowels, 2, 'Replace', false)];
        end
        vowel1 = vowel_order(:, 1);
        vowel2 = vowel_order(:, 2);
    
        % Make sure count of each vowel is min 8 max 12
        if check_counts(vowel1) && check_counts(vowel2)
            break
        end
            
    end
    
    function break_loop = check_counts(seq)
        counts = groupcounts(seq);
        if sum(counts <= 8) || sum(counts >= 12)
            break_loop = false;
        else
            break_loop = true;
        end
    end
end
