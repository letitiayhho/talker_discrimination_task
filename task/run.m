%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 0; % numeric
BLOCK = 2; % numeric

%%%%%%%%%%%%%%%%%%%%%%%
      
PsychDebugWindowConfiguration

%% Set up
cd('~/src/talker_discrimination_task/')
addpath('task/functions')
addpath('generate_stim_order')
PsychJavaTrouble(1);

% other constants      
FS = 44100;

% set up psychtoolbox and RTBox
PTB = init_psychtoolbox(FS);

% Load stim order
[STIM, SAME_KEY, N_TRIALS, BLOCK_TYPE] = generate_stim_order(SUBJ_NUM, BLOCK);

%% Display instructions
update_instructions(SAME_KEY)  
instructions(PTB, BLOCK);

%% Task
for trial = 1:N_TRIALS
    [stim1, stim2, same, key] = get_rep_stim(STIM, BLOCK, trial);
    
    WaitSecs(2)
    fixation(PTB); % show fixation cross to start trial
    
    present_stimulus(PTB, stim1);
    WaitSecs(.1 + rand()*.05);
    present_stimulus(PTB, stim2);
    [rt, resp] = collect_response(PTB);
    correct = check_answer(key, resp);
    write_output(SUBJ_NUM, BLOCK, BLOCK_TYPE, trial, stim1, stim2, same,...
        rt, key, resp, correct);
    
    if strcmp(BLOCK_TYPE, "training")
        give_feedback(correct, PTB);
    end
end

%% end block
instructions(PTB, 0) 

sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles
