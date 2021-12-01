function update_instructions(block, same_key)
    % Identify the key for different pairs
    keys = ["1", "4"];
    different_key = keys(keys ~= same_key);
    block = num2str(block-1);

    %% Instructions_2.txt
    % Load instructions and replace "same" with "different"
    txt = load_text_from('task/instructions/instructions_2_template.txt');
    txt = regexprep(txt, '<same>', same_key);
    txt = regexprep(txt, '<different>', different_key);

    % Update txt file
    fileID = fopen('task/instructions/instructions_2.txt','w');
    fprintf(fileID, txt);
    fclose(fileID);
    
    %% Instructions_6.txt
    % Load instructions and replace "same" with "different"
    txt = load_text_from('task/instructions/instructions_6_template.txt');
    txt = regexprep(txt, '<same>', same_key);
    txt = regexprep(txt, '<different>', different_key);
    txt = regexprep(txt, '<block>', block);

    % Update txt file
    fileID = fopen('task/instructions/instructions_6.txt','w');
    fprintf(fileID, txt);
    fclose(fileID);
end