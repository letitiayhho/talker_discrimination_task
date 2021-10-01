function [talker1_order, talker2_order, same_order, key_order] = get_talker_order()
    talker1 = ["A"; "B"; "B"; "A"; "X"; "Y"; "Y"; "X"];
    talker2 = ["A"; "B"; "A"; "B"; "X"; "Y"; "X"; "Y"];
    same = [1; 1; 0; 0; 1; 1; 0; 0];
    key = ["c", "m"; "c", "m"; "m", "c"; "m", "c";...
        "c", "m"; "c", "m"; "m", "c"; "m", "c"];
    key = key(:, randi(2));
    
    % Training trials
    order = randperm(8);
    talker1_order = talker1(order);
    talker2_order = talker2(order);
    same_order = same(order);
    key_order = key(order);
    
    % Generate order
    for i = 1:20
        order = randperm(8);
        talker1_order = [talker1_order; talker1(order)];
        talker2_order = [talker2_order; talker2(order)];
        same_order = [same_order; same(order)];
        key_order = [key_order; key(order)];
    end
    
    % Make sure there aren't more than 3 same or different trials in a row
    for j = 1:length(same_order)-5
        window = j:j+5;
        if (sum(same_order(window)) == 0) || (sum(same_order(window)) == 5)
            % Generate talker order recursively until condition is met
            [talker1_order, talker2_order, same_order, key_order] = get_talker_order();
        end
    end
end