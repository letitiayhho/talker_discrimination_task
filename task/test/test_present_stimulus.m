sca;
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles

%% Set up
PsychDebugWindowConfiguration
cd('~/src/talker_discrimination_task/')
addpath('task/functions')

% Constants
SUBJ_NUM = 0;
BLOCK = 2;
REP = 1;
FS = 44100;
PTB = init_psychtoolbox(FS);

% Load stim
stim_file = ['generate_stim_order/output/', num2str(SUBJ_NUM), '_stim_order.txt'];
STIM = readtable(stim_file);
[stim, ~, ~] = get_rep_stim(STIM, BLOCK, REP);

%%
% present_stimulus(PTB, stim)

% [aud, ~] = audioread(stim);
% PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
% 
% % show stim playing
% DrawFormattedText(ptb.window, '-', 'center', 'center', 1);
% Screen('Flip', ptb.window);
% 
% % play audio
% t0 = GetSecs + .001;
% PsychPortAudio('Start', ptb.pahandle, 1, t0, 1);
% 
% % send trigger
% WaitSecs(.001); %length of 1 ms
% RTBox('TTL', 255)
% 
% % stop audio
% PsychPortAudio('Stop', ptb.pahandle, 1, 1);
% Screen('Flip', ptb.window);
% WaitSecs(.2 + rand()*.2);

