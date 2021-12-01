function [talker1_order, talker2_order, same_order, key_order, vowel_space] = get_talker_order(same_key, vowel_space, n_trials)

    [talker1, talker2, same, key] = get_block_talkers(vowel_space, same_key);

    while true
        talker1_order = [];
        talker2_order = [];
        same_order = [];
        key_order = [];

        % Generate order
        for i = 1:n_trials/length(talker1)
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

function break_loop = check_repeats(same_order)
    for j = 1:length(same_order)-5
        window = j:j+5;
        if (sum(same_order(window)) == 0) || (sum(same_order(window)) == 5)
            % Generate talker order recursively until condition is met
            break_loop = false;
            return
        end
    end
    break_loop = true;
end
