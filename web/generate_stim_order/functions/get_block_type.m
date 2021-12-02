function [vowel_space, n_trials] = get_block_type()
    if rand < 0.5
        vowel_space = ["training", "s", "d", "s", "d"];
    else
        vowel_space = ["training", "d", "s", "d", "s"];
    end
    n_trials = [16, 48, 48, 48, 48];
end