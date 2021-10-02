function [block_order, n_trials] = get_block_order()
    if rand < 0.5
        block_order = ["training", "same", "different", "same", "different"];
    else
        block_order = ["training", "different", "same", "different", "same"];
    end
    n_trials = [8, 40, 40, 40, 40];
end