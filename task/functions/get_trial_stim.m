function [stim1, stim2, same, key] = get_trial_stim(stim_order, rep)
    % subset by block and rep
    stim_order = stim_order(stim_order.rep == rep, :);
        
    % get stim paths
    stim1 = get_stim_path(stim_order.talker1, stim_order.vowel1, stim_order.exemplar1);
    stim2 = get_stim_path(stim_order.talker2, stim_order.vowel2, stim_order.exemplar2);
    same = stim_order.same;
    key = stim_order.key;
end