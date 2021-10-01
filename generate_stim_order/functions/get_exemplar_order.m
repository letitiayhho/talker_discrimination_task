function [exemplar_order] = get_exemplar_order()
    exemplars = (1:3)';
    exemplar_order = [];
    for i = 1:56
        exemplar_order = [exemplar_order; randperm(3)'];
    end
end