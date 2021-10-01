function update_instructions(same_key)
    % Identify the key for different pairs
    keys = ['c', 'm'];
    different_key = keys(keys ~= same_key);

    % Load instructions and replace "same" with "different"
    txt = load_text_from('task/instructions/instructions_2_template.txt');
    txt = regexprep(txt, '<same>', same_key);
    txt = regexprep(txt, '<different>', different_key);

    % Update txt file
    fileID = fopen('task/instructions/instructions_2.txt','w');
    % fprintf(fileID,'%6s %12s\n','x','exp(x)');
    fprintf(fileID, txt);
    fclose(fileID);
end