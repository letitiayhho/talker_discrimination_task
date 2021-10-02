function [correct] = check_answer(key, resp)
    correct = strcmp(key, resp);
end