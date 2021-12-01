function [rt, resp] = collect_response(ptb)

    % start collecting response
    ListenChar(2); % disable matlab command window
    RTBox('clear');
    Priority(2);

    % show response accepting
    response_timer = tic;
    DrawFormattedText(ptb.window, 'x', 'center', 'center', 1);
    resp_start = Screen('Flip', ptb.window);

    % wait for response
    timeout = 2;
    [rt, resp] = RTBox(timeout);
    rt = rt - resp_start; %  response time
    resp = string(resp);
    
    % check response
    if numel(rt) > 1 
        rt = rt(1); % keep only first repsonse
        resp = string(resp{1});
    end
    if isempty(rt) % no response
        rt = "nan";
        resp = "nan";
    end
    
    % control response time
    response_window = 2;
    WaitSecs(response_window-toc(response_timer));
    
    % end of accepting response
    Screen('Flip', ptb.window);
    ListenChar(0); % renables matlab command window
    Priority(0);

end