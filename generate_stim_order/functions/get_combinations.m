function [permutations] = get_permutations()
    talker_pairs = ["A", "A"; "A", "A"; "B", "B"; "B", "B"; "A", "B"; "B", "A";...
        "X", "X"; "X", "X"; "Y", "Y"; "Y", "Y"; "X", "Y"; "Y", "X"];
    vowels = ["AH"; "EH"; "IH"; "OO"];
    exemplars = (1:3)';

    permutations = [];
    for pair = 1:size(talker_pairs, 1)
        for vowel = 1:size(vowels, 1)
            for exemplar = 1:size(exemplars, 1)
                permutations = [permutations;...
                    cellstr(talker_pairs(pair, :)),...
                    cellstr(vowels(vowel)),...
                    exemplars(exemplar)];
            end
        end
    end

    permutations = cell2table(permutations);
    permutations.Properties.VariableNames = {'talker1', 'talker2', 'vowel', 'exemplar'};
end