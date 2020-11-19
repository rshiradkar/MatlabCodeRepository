% clear;close all;clc;
tic
% intensity standardization and feature extraction

% create template volume for standardization
% create_template;
template_volume=tem_vol;
options.zeroval=0;
options.docheck=true;
%

for i = 2:2
    
    studies = {'case17_2','case16_2','case21_4'};
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
        
        % Read skull_stripped_mask
        eval(['skull_mask= ReadData3D(''/Users/Happy/Documents/Matlab/rGBM_Nec/Nec_Tumor/recurrent_metastasis/',studies{i},'/registration results/T1_skull.mha'');'])
        
        % Read tumor/necrosis mask
        eval(['mask= ReadData3D(''/Users/Happy/Documents/Matlab/rGBM_Nec/Nec_Tumor/recurrent_metastasis/',studies{i},'/registration results/T1-label.mha'');'])
        
        % T1_rot=rotate(T1_orig)
        eval([protnames{j},'_rot= rot90_3D(',protnames{j},'_orig, 3, 3);'])
        
        % skull_mask_rot=rotate(skull_mask)
        eval('skull_mask_rot= rot90_3D(skull_mask, 3, 3);')
        
        % tumor/necrosis_mask_rot=rotate(mask)
        eval('mask_rot= rot90_3D(mask, 3, 3);')
        
        %find start,end slice, and number of slices
        [slice_start, slice_end, num_slice]=calculate_start_end(skull_mask_rot);
        
        %rotate the required slices and save to 'StudyXX.T1'
        eval([studies{i},'.',protnames{j},'= rot90_3D(',protnames{j},'_orig(:,:,slice_start:slice_end), 3, 3);'])
        
        %rotate the required skull_masks and save to 'StudyXX.skull_mask'
        eval([studies{i},'.skull_mask_T1 = skull_mask_rot(:,:,slice_start:slice_end);'])
        
        %rotate the required masks and save to 'StudyXX.mask'
        eval([studies{i},'.mask_T1 = mask_rot(:,:,slice_start:slice_end);'])
        
        
        
    end
    
    temp_vol=[];
    [slice_start, slice_end, num_slice]=calculate_start_end(skull_mask_rot);
    eval([studies{i},'.num_slice_T1 = num_slice;'])
    for n=1:num_slice
        eval(['tem=',studies{i},'.skull_mask_T1(:,:,n).*',studies{i},'.',protnames{j},'(:,:,n);'])
        temp_vol(:,:,n)=tem;
    end
    eval([studies{i},'.current_volume_T1 = temp_vol;'])
    [standardized_vol,STANDARDIZATION_MAP] = int_stdn_landmarks(temp_vol,template_volume,options);
    eval([studies{i},'.standardized_volume_T1 = standardized_vol;'])
end

toc

%Now we have standardized volumes of different cases
% Next step: feature extraction

%volume 1: n1 slices

































% 
% 
% for i = 1:1
%     
%     sl_st = [5];
%     sl_end = [10];
%     
%     studies = {'case17_2'};
%     protnames = {'T1'};
%     for j = 1:1
%         filename = ['/Users/Happy/Documents/Matlab/rGBM_Nec/Nec_Tumor/recurrent_metastasis/',studies{i},'/registration results/',protnames{j},'.mha'];
%         if exist(filename)
%             eval([protnames{j},'_orig= ReadData3D(filename);'])
%             eval(['mask= ReadData3D(''/Users/Happy/Documents/Matlab/rGBM_Nec/Nec_Tumor/recurrent_metastasis/',studies{i},'/registration results/T1-label.mha'');'])
%             eval([protnames{j},'_rot= rot90_3D(',protnames{j},'_orig, 3, 3);'])
%             eval('mask_rot= rot90_3D(mask, 3, 3);')
%             
%             for m = 1:size(T1_rot,3)
%                 eval([protnames{j},'_flip','(:,:,',num2str(m),')= fliplr(',protnames{j},'_rot(:,:,',num2str(m),'));']);
%                 %   eval(['mask_flip','(:,:,',num2str(m),')= fliplr(mask_rot(:,:,',num2str(m),'));']);
%             end
%             eval([studies{i},'.',protnames{j},'= rot90_3D(',protnames{j},'_orig(:,:,sl_st(i):sl_end(i)), 3, 3);'])
%             eval(['[',studies{i},'.',protnames{j},'_feats,names,nfeats]= textures3(',studies{i},'.',protnames{j},'.*mask_rot(:,:,sl_st(i):sl_end(i)),0);'])
%             
%         else
%             warningMessage = sprintf('Warning: file does not exist:\n%s', filename);
%             % uiwait(msgbox(warningMessage));
%         end
%     end
%     eval([studies{i},'.mask = mask_rot(:,:,sl_st(i):sl_end(i));'])
%     
%     save(['Y:\UH_RN_rGBM_Brain_MRI\new_studies\',studies{i},'\restructered\',studies{i},'.mat'],studies{i},'names','-v7.3');
%     sprintf('finished study =:\n%s',num2str(i))
%     clear
% end
