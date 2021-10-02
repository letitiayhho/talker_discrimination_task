function [block_type, n_trials] = get_block_order(BLOCK)
    if rand < 0.5
        block_order = ["training", "same", "different", "same", "different"];
    else
        block_order = ["training", "different", "same", "different", "same"];
    end
    block_type = block_order(BLOCK);
    n_trials = [8, 40, 40, 40, 40];
    n_trials = n_trials(BLOCK);
end