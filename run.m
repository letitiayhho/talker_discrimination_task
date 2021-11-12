%%%%%%%%%%%%%%%%%%%%%%%%% UPDATE THIS SECTION BEFORE EACH SUBJECT/TEST

SUBJ_NUM = 0; % numeric
PILOT = true; % logical
TEST = false; % logical

%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set up
cd('C:\Users\Nusbaum Lab\Desktop\talker_discrimination_task')
addpath('generate_stim_order')
addpath('task/functions')
addpath('task/USTCRTBox_003')  
PsychJavaTrouble(1);
isWindowsAdmin;

if TEST
    RTBOX = false;
else
    RTBOX = true;
end

% set up psychtoolbox and RTBox
FS = 44100;
PTB = init_psychtoolbox(FS);
init_RTBox(RTBOX);

%% Loop over blocks
BLOCKS = 2:5;

for BLOCK = BLOCKS
    % Load stim order
    [STIM, SAME_KEY, N_TRIALS] = generate_stim_order(SUBJ_NUM, BLOCK);

    %% Display instructions
    update_instructions(BLOCK, SAME_KEY)  
    instructions(PTB, BLOCK);
    tic

    %% Task
    for trial = 1:N_TRIALS
        iti = 5;
        WaitSecs(iti - toc);
        tic
        [stim1, stim2, same, key] = get_trial_stim(STIM, trial);
        
        fixation(PTB); % show fixation cross to start trial
        WaitSecs(1.25 - toc);
        
        present_stimulus(PTB, stim1);
        WaitSecs(2 - toc);
        present_stimulus(PTB, stim2);
        [rt, resp] = collect_response(PTB);
        correct = check_answer(key, resp);
        write_output(SUBJ_NUM, BLOCK, STIM(trial,:), rt, resp, correct, PILOT)

        if BLOCK == 1
            give_feedback(correct, PTB);
        end
    end

    %% end block
    instructions(PTB, 0) 
    
end

sca; % screen clear all
close all;
clearvars;
PsychPortAudio('Close'); % clear audio handles
clear all;
