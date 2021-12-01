function [stim_path] = get_stim_path(talker_order, vowel_order, exemplar_order)
    filename = strcat(vowel_order, num2str(exemplar_order), '.wav');
    stim_path = fullfile('stim', talker_order, filename);
end