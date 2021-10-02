function [talker1_order, talker2_order, same_order, key_order, n_trials, same_key, block_type] = get_talker_order(BLOCK)

[block_type, n_trials] = get_block_type(BLOCK); 
[talker1, talker2, same, key, same_key] = get_block_talkers(block_type);

while true
    talker1_order = [];
    talker2_order = [];
    same_order = [];
    key_order = [];

    % Generate order
    for i = 1:round(n_trials/length(talker1))
        order = randperm(length(talker1));
        talker1_order = [talker1_order; talker1(order)];
        talker2_order = [talker2_order; talker2(order)];
        same_order = [same_order; same(order)];
        key_order = [key_order; key(order)];
    end
    
    % Make sure there aren't more than 4 same or different trials in a row
    if check_repeats(same_order)
        break
    end
end
end

function [cont] = check_repeats(same_order)
    for j = 1:length(same_order)-5
        window = j:j+5;
        if (sum(same_order(window)) == 0) || (sum(same_order(window)) == 5)
            % Generate talker order recursively until condition is met
            cont = false;
            return
        end
    end
    cont = true;
    return
end
