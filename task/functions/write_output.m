function write_output(subject, block, rep, stim1, stim2, same, rt, resp, correct)

    % get output filename for this subject and black
    fpath = ['task/output/subj' num2str(subject) 'block' num2str(block) '.csv'];
    
    % create data frame
    row = {num2str(subject), num2str(block), num2str(rep), char(stim1),...
        char(stim2), num2str(same), num2str(rt), num2str(resp), num2str(correct)};
    row = strjoin(row, ',');
    row = ['\n' row];
    
    if ~(exist(fpath, 'file') == 2) % ~isfile(fpath) in later versions
        cols = 'subject,block,rep,stim1,stim2,same,rt,resp,correct';
        row = [cols row];
        f = fopen(fpath, 'wt'); 
        fprintf(f, row);
        fclose(f);
    else
        f = fopen(fpath, 'a');
        fprintf(f, row); 
        fclose(f);
    end

end