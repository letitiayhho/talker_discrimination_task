function [vowel_order] = get_vowel_order()
    possible_vowels = ["AH", "EH", "IH", "OO"];
    vowel_order = [];
    for i = 1:62
        vowel_order = [vowel_order; datasample(possible_vowels, 4, 'Replace', false)'];
    end
end
