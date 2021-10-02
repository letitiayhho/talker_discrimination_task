function present_stimulus(ptb, stim)

    [aud, ~] = audioread(char(stim));
    PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);

    % show stim playing 
    DrawFormattedText(ptb.window, '-', 'center', 'center', 1);
    Screen('Flip', ptb.window);

    % play audio
    t0 = GetSecs + .001;
    PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);

    % stop audio
    PsychPortAudio('Stop', ptb.pahandle, 1, 1);
    Screen('Flip', ptb.window);
    WaitSecs(.5 + rand()*.2);

end