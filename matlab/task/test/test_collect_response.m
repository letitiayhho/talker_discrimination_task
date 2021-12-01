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

% Load stimd
stim_file = ['generate_stim_order/output/', num2str(SUBJ_NUM), '_stim_order.txt'];
STIM = readtable(stim_file);
[stim, ~, ~] = get_rep_stim(STIM, BLOCK, REP);

%%
present_stimulus(PTB, stim)
[rt, resp] = collect_response(PTB);

sca