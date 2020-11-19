
%function template_volume=create_template

clear;close all;clc;
for i = 1:1
    
    studies = {'case17_2'};
%     studies_refined={'case17_2_ref'};
%     
    protnames = {'T1'};
%     eval(['[',studies_refined{i},'.',protnames{j},'=[]]'])
%     protnames1= {'mask'};
    for j = 1:1
        % Read original image
        filename = ['/Users/Happy/Documents/Matlab/rGBM_Nec/Nec_Tumor/recurrent_metastasis/',studies{i},'/registration results/',protnames{j},'.mha'];
        
        % Save to T1_orig
        eval([protnames{j},'_orig= ReadData3D(filename);'])
        
        % Read skull_stripped
        eval(['mask= ReadData3D(''/Users/Happy/Documents/Matlab/rGBM_Nec/Nec_Tumor/recurrent_metastasis/',studies{i},'/registration results/T1_skull.mha'');'])
        
        % T1_rot=rotate(T1_orig)
        eval([protnames{j},'_rot= rot90_3D(',protnames{j},'_orig, 3, 3);'])
        
        % mask_rot=rotate(mask)
        eval('mask_rot= rot90_3D(mask, 3, 3);')
        
        %find start,end slice, and number of slices
        [slice_start, slice_end, num_slice]=calculate_start_end(mask_rot);
        
        %rotate the required slices and save to 'StudyXX.T1'
        eval([studies{i},'.',protnames{j},'= rot90_3D(',protnames{j},'_orig(:,:,slice_start:slice_end), 3, 3);'])
        
        %rotate the required masks and save to 'StudyXX.mask'
        eval([studies{i},'.mask = mask_rot(:,:,slice_start(i):slice_end(i));'])
        
        
        
    end
end
tem_vol=[];
[slice_start, slice_end, num_slice]=calculate_start_end(mask_rot);
for n=1:num_slice
    eval(['tem=',studies{i},'.mask(:,:,n).*',studies{i},'.',protnames{j},'(:,:,n);'])
    tem_vol(:,:,n)=tem;
end

% [slice_start, slice_end, num_slice]=calculate_start_end(mask_rot);
% for n=1:num_slice
%     eval(['[',studies_refined{i},'.',protnames{j},'(:,:,n)=',studies{i},'.',protnames{j},'(:,:,n).*',studies{i},'.',protnames1{j},'(:,:,n);]'])
% end
    

