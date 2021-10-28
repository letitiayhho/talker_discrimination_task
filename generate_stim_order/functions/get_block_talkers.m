function [talker1, talker2, same, key] = get_block_talkers(block_type, same_key)
if strcmp(block_type, "training")
    talker1 = ["A"; "B"; "B"; "A"; "X"; "Y"; "X"; "Y"];
    talker2 = ["A"; "B"; "A"; "B"; "X"; "Y"; "Y"; "X"];
elseif strcmp(block_type, "same")
    talker1 = ["A"; "B"; "B"; "A"];
    talker2 = ["A"; "B"; "A"; "B"];
elseif strcmp(block_type, "different")
    talker1 = ["X"; "Y"; "X"; "Y"];
    talker2 = ["X"; "Y"; "Y"; "X"];
end

same = get_same(talker1, talker2);
key = get_key(same, same_key);

    function [same] = get_same(talker1, talker2)
        same = talker1 == talker2;
    end

    function [key] = get_key(same, same_key)
        keys = ["1", "4"];
        keys(strcmp(keys, same_key)) = [];
        different_key = keys;
        
        key = num2str(same);
        key(logical(same)) = same_key;
        key(~logical(same)) = different_key;
    end
end