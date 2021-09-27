function [stim_path] = get_stim_path(talker_order, vowel_order)
    stim_path = fullfile('stim', talker_order, strcat(vowel_order, '.wav'));
end