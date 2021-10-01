function [talker1_order, talker2_order, same_order] = get_talker_order()
    talker1 = ["A"; "A"; "B"; "B"; "X"; "X"; "Y"; "Y"];
    talker2 = ["A"; "B"; "A"; "B"; "X"; "Y"; "X"; "Y"];
    same = [1; 0; 0; 1; 1; 0; 0; 1];
    
    % Training trials
    order = randperm(8);
    talker1_order = talker1(order);
    talker2_order = talker2(order);
    same_order = same(order);
        
    % Double frequency of same-talker trials for test trials
    talker1 = [talker1; "A"; "B"; "X"; "Y"];
    talker2 = [talker2; "A"; "B"; "X"; "Y"];
    same = [same; 1; 1; 1; 1];
    
    % Generate order
    for i = 1:20
        order = randperm(12);
        talker1_order = [talker1_order; talker1(order)];
        talker2_order = [talker2_order; talker2(order)];
        same_order = [same_order; same(order)];
    end
    
    % Make sure there aren't more than 3 same or different trials in a row
    for j = 1:length(same_order)-8
        window = j:j+8;
%         same_order(window)
        if (sum(same_order(window)) == 0) || (sum(same_order(window)) == 8)
            % Generate talker order recursively until condition is met
            [talker1_order, talker2_order, same_order] = get_talker_order();
        end
    end
end