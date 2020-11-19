clear;close all;clc;

 
for i = 1:1

 sl_st = [5];
 sl_end = [10];

studies = {'case16_2'};
protnames = {'T1'};
    for j = 1:1
        filename = ['/Users/Happy/Documents/Matlab/rGBM_nec/Nec_Tumor/recurrent_metastasis/',studies{i},'/registration results/',protnames{j},'.mha'];
        if exist(filename)
            eval([protnames{j},'_orig= ReadData3D(filename);'])
            eval(['mask= ReadData3D(''/Users/Happy/Documents/Matlab/rGBM_nec/Nec_Tumor/recurrent_metastasis/',studies{i},'/registration results/T1-label.mha'');'])
            eval([protnames{j},'_rot= rot90_3D(',protnames{j},'_orig, 3, 3);'])
            eval('mask_rot= rot90_3D(mask, 3, 3);')
            
  for m = 1:size(Gd_T1_rot,3)
     eval([protnames{j},'_flip','(:,:,',num2str(m),')= fliplr(',protnames{j},'_rot(:,:,',num2str(m),'));']);
  %   eval(['mask_flip','(:,:,',num2str(m),')= fliplr(mask_rot(:,:,',num2str(m),'));']);
  end
eval([studies{i},'.',protnames{j},'= rot90_3D(',protnames{j},'_orig(:,:,sl_st(i):sl_end(i)), 3, 3);'])
eval(['[',studies{i},'.',protnames{j},'_feats,names,nfeats]= textures3(',studies{i},'.',protnames{j},'.*mask_rot(:,:,sl_st(i):sl_end(i)),0);'])

else
warningMessage = sprintf('Warning: file does not exist:\n%s', filename);
 % uiwait(msgbox(warningMessage));    
        end
    end
    eval([studies{i},'.mask = mask_rot(:,:,sl_st(i):sl_end(i));'])
   
    save(['Y:\UH_RN_rGBM_Brain_MRI\new_studies\',studies{i},'\restructered\',studies{i},'.mat'],studies{i},'names','-v7.3');
    sprintf('finished study =:\n%s',num2str(i))
     clear
end