function [same_key] = get_same_key(STIM)
    same_key = char(unique(STIM.key(STIM.same == 1)));
end