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
end