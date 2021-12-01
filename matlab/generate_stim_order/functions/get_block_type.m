function [block_type, n_trials] = get_block_type(BLOCK)
    if rand < 0.5
        block_order = ["training", "s", "d", "s", "d"];
    else
        block_order = ["training", "d", "s", "d", "s"];
    end
    block_type = block_order(BLOCK);
    n_trials = [16, 48, 48, 48, 48];
    n_trials = n_trials(BLOCK);
end