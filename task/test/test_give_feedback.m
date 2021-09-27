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
[stim, ~, same] = get_rep_stim(STIM, BLOCK, REP);

%% Test one
present_stimulus(PTB, stim)
[rt, resp] = collect_response(PTB);
correct = check_answer(same, resp);

%% Test multiple
% stim = readtable('generate_stim_order/output/stim_order.txt');
% stim_path = get_filepaths(stim);
% target = get_target(stim);
% 
% for s = 1:length(stim_path)
%     [stim_start, stim_end, pressed, rt, resp] = present_stimulus(stim_path(s), BLOCK, ptb); % trigger sent here
%     correct = check_answer(stim.target(s), resp);
%     write_output(SUBJ_NUM, BLOCK, s, stim.vowel(s), stim_start, stim_end, pressed, rt, resp, correct);
% %     if training
%         give_feedback(correct, ptb);
%     end
% end

% test check_answer and give_feedback with correct answer
% test with incorrect answer
% test with impossible answer
% test write_ouput

sca;