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

%% Play audio
[aud, ~] = audioread(stim);
PsychPortAudio('FillBuffer', ptb.pahandle, [aud'; aud']);
ListenChar(2); % suppresses typing into matlab command window
PsychPortAudio('Start', ptb.pahandle, 1, 0, 1);

% collect response
[pressed, rt, resp] = KbCheck; % test with GetKeyboardIndices
PsychPortAudio('Stop', ptb.pahandle, 1, 1);
ListenChar(0);
fprintf([num2str(pressed), '\n'])
fprintf([num2str(rt), '\n'])
fprintf([num2str(find(resp)), '\n'])

%% End
sca; % screen clear all
close all;
% clearvars;
PsychPortAudio('Close'); % clear audio handles