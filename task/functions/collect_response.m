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
    while ~pressed
        [pressed, rt] = KbQueueCheck(); %check response
    end
    
    % save key identity and rt
    keylist = KbName(rt);
    [rt, I] = min(rt(rt > 0)); % keep only first response
    resp = char(keylist(I));
    rt = rt - resp_start;

    % end of accepting response
    Screen('Flip', ptb.window);

end