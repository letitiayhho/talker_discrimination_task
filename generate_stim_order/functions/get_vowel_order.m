function [vowel1, vowel2] = get_vowel_order(n_trials)
    possible_vowels = ["AA", "EH", "IH", "OO"];
    vowel_order = [];
    for i = 1:n_trials/length(possible_vowels)
        vowel_order = [vowel_order; datasample(possible_vowels, 2, 'Replace', false)];
    end
    vowel1 = vowel_order(:, 1);
    vowel2 = vowel_order(:, 2);
end
