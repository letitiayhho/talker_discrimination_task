function same_key = get_same_key(group_number)        
    keys = ['f', 'j'];
    same_key = keys(mod(group_number, 2)+1);
end