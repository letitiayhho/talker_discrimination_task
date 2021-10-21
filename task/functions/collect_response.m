function [rt, resp] = collect_response(ptb)

    % show response accepting
    DrawFormattedText(ptb.window, 'x', 'center', 'center', 1);
    Screen('Flip', ptb.window);
    
    % start collecting response
    ListenChar(2); % disable matlab command window
    KbQueueCreate(ptb.keyboard);
    KbQueueStart;
    resp_start = GetSecs;

    % wait for response
    pressed = 0;
    times_up = 0;
    while ~pressed
        [pressed, rt] = KbQueueCheck(); %check response
        times_up = GetSecs - resp_start > 1.5;
        if times_up
            break
        end
    end
    
    % save key identity and rt
    if sum(rt) > 0
        keylist = KbName(rt);
        [rt, I] = min(rt(rt > 0)); % keep only first response
        resp = char(keylist(I));
        rt = rt - resp_start;
    else
        resp = "NaN";
        rt = "NaN";
    end

    % end of accepting response
    Screen('Flip', ptb.window);
    ListenChar(0); % renables matlab command window

end