function [correct] = check_answer(same, resp)
    same = logical(same);
    if resp == "" % catch empty answers
        correct = 0;
    elseif same && resp == 's' % correctly identifies target
        correct = 1;
    elseif ~same && resp == 'd' % correctly identifies non-targets
        correct = 1;
    else % all other cases
        correct = 0;
    end
end