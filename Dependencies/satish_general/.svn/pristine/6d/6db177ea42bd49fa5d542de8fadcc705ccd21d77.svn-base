function rename_folders(root_folder, old_list, new_list)

    all_folders = dir(root_folder);
    
    for i = 1:length(old_list)
        
        % this is the old directory name
        current_string = old_list{i};
        
        found = false;
        for j = 1:length(all_folders)
            if strfind(upper(all_folders(j).name), upper(current_string))
                found = true;
                break;
            end
        end % for j
        
        if found
            % rename the directory
            movefile(sprintf('%s\\%s', root_folder, all_folders(j).name), sprintf('%s\\%s', root_folder, new_list{i}));
        end 
        
    end % for i

end % function