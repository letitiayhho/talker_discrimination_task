%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 0; % numeric
BLOCK = 2; % numeric
RTBOX = false; % logical

%%%%%%%%%%%%%%%%%%%%%%%
      
% PsychDebugWindowConfiguration

%% Set up
cd('~/src/talker_discrimination_task/')
addpath('task/functions')
% addpath('task/USTCRTBox_003')      
% PsychJavaTrouble(1);

% other constants      
FS = 44100;
IS_TRAINING = BLOCK == 1 || BLOCK == 2; % change training depending on block number

% set up psychtoolbox and RTBox
% init_RTBox(RTBOX);
% PTB = init_psychtoolbox(FS);

% Load stim order
stim_file = ['generate_stim_order/output/', num2str(SUBJ_NUM), '_stim_order.txt'];
STIM = readtable(stim_file);

%% Display instructions
% instructions(PTB, BLOCK);

%% Task
% loop through all reps in block
n_reps = get_n_reps(STIM, BLOCK);

for rep = 1:n_reps
    [stim1, stim2, same] = get_rep_stim(STIM, BLOCK, rep);

%     WaitSecs(2)
%     fixation(PTB); % show fixation cross to start trial

%         present_stimulus(PTB, stim1); % trigger sent here
%         present_stimulus(PTB, stim2); % trigger sent here
%         [rt, resp] = collect_response(PTB);
%         correct = check_answer(same, resp);
%         write_output(SUBJ_NUM, BLOCK, rep, stim1, stim2, rt, resp,
%         correct); FIX THIS
%         if IS_TRAINING
%             give_feedback(correct, PTB);
%         end
%     end
end

%% end block
instructions(PTB, 0) 

sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles
