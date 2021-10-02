%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 0; % numeric
BLOCK = 2; % numeric
RTBOX = false; % logical

%%%%%%%%%%%%%%%%%%%%%%%
      
% PsychDebugWindowConfiguration

%% Set up
cd('~/src/talker_discrimination_task/')
addpath('task/functions')
addpath('generate_stim_order')
% addpath('task/USTCRTBox_003')      
% PsychJavaTrouble(1);

% other constants      
FS = 44100;
IS_TRAINING = BLOCK == 1 || BLOCK == 2; % change training depending on block number

% set up psychtoolbox and RTBox
% init_RTBox(RTBOX);
% PTB = init_psychtoolbox(FS);

% Load stim order
[STIM, SAME_KEY, N_TRIALS] = generate_stim_order(subject_number, BLOCK);

%% Display instructions
update_instructions(SAME_KEY)
instructions(PTB, BLOCK);

%% Task
for rep = 1:N_TRIALS
    [stim1, stim2, same] = get_rep_stim(STIM, BLOCK, rep);
    
    WaitSecs(2)
    fixation(PTB); % show fixation cross to start trial
    
    present_stimulus(PTB, stim1); % trigger sent here
    present_stimulus(PTB, stim2); % trigger sent here
    [rt, resp] = collect_response(PTB);
    correct = check_answer(same, resp);
    write_output(SUBJ_NUM, BLOCK, rep, stim1, stim2, same, rt, resp,...
        correct); FIX THIS
    if IS_TRAINING
        give_feedback(correct, PTB);
    end
end

%% end block
instructions(PTB, 0) 

sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles
