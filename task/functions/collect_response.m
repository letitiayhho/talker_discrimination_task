function [rt, resp] = collect_response(ptb)

    % start collecting response
    ListenChar(2); % disable matlab command window
    RTBox('clear');
    Priority(1);

    % show response accepting
    DrawFormattedText(ptb.window, 'x', 'center', 'center', 1);
    resp_start = Screen('Flip', ptb.window);

    % wait for response
    timeout = 1.5;
    [rt, resp] = RTBox(timeout);
    
    % check response
    if isempty(rt) % no response
        rt = "nan";
        resp = "nan";
    else 
        rt = rt - resp_start; %  response time
        resp = string(resp);
    end
    if numel(rt) > 1 % more than 1 response
        ind = find(rt>0,1); % use 1st proper rt
        rt = rt(ind);
        resp = resp{ind};
    end

    % end of accepting response
    Screen('Flip', ptb.window);
    ListenChar(0); % renables matlab command window
    Priority(0);

end