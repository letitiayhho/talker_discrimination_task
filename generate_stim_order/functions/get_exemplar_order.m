function [exemplar_order] = get_exemplar_order()
    exemplars = (1:3)';
    exemplar_order = [];
    for i = 1:82
        exemplar_order = [exemplar_order; randperm(3)'];
    end
    exemplar_order = [exemplar_order; 1; 2]; % make 248
end