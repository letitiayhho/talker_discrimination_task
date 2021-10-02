function [talker1_order, talker2_order, same_order, key_order] = get_talker_order(trials, talker1, talker2, same, key)

% % test that trials is divisible by 8
% 
% %  "X"; "Y"; "X"; "Y"];
% %   "X"; "Y"; "Y"; "X"];
% % talker1 = ["A"; "B"; "B"; "A"];
% % talker2 = ["A"; "B"; "A"; "B"];
% % same = [1; 1; 0; 0; 1; 1; 0; 0];
% % key = ["c", "m"; "c", "m"; "m", "c"; "m", "c"];
% % key = key(:, randi(2));
% 
% % move this stuff to other func
% % key = ["c", "m"; "c", "m"; "m", "c"; "m", "c"];
% % key = key(:, randi(2));



while true
%     % Training trials
%     order = randperm(8);
%     talker1_order = talker1(order);
%     talker2_order = talker2(order);
%     same_order = same(order);
%     key_order = key(order);
    talker1_order = [];
    talker2_order = [];
    same_order = [];
    key_order = [];


    % Generate order
    for i = 1:round(trials/length(talker1))
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
