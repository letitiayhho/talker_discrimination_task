function [correct] = check_answer(key, resp)
    if strcmp(key, resp)
        correct = 1;
    else
        correct = 0;
end