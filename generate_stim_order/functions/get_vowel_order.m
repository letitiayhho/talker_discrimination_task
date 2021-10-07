function vowel_order = get_vowel_order(n_trials)
    possible_vowels = ["AA", "EH", "IH", "OO"];
    vowel_order = [];
    for i = 1:n_trials/length(possible_vowels)
        vowel_order = [vowel_order; datasample(possible_vowels, 4, 'Replace', false)'];
    end
end
