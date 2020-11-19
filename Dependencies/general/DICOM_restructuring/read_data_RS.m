%**** Read raw data and restructure ******%
addpath(genpath('Matlab_scripts'));
% 
% mDir = '/mnt/projects/CSE_BME_AXM788/data/MtSinai_Prostate_MRI/RadioGenomics/MRI';
% sDir = '/mnt/projects/CSE_BME_AXM788/data/MtSinai_Prostate_MRI/RadioGenomics/restructured';
mDir = 'Z:\data\MtSinai_Prostate_MRI\RadioGenomics\MRI';
sDir = 'Z:\data\MtSinai_Prostate_MRI\RadioGenomics\restructured';

folderfields={'PatientName.FamilyName','StudyDate','StudyDescription','SeriesDescription','SeriesNumber'};

folders = dir(mDir); folders = folders(3:end,:);
% N = length(folders);
N = length(list);
% parpool;

for i = 1:N
%     prompt = 'What is the case number? ';
%     case_num = input(prompt);
  %  prompt = 'What is the sub-case number? '; %Uncomment
  %  sub_case_num = input(prompt);    %Uncomment
   % [DICOMDIRDATA,NONDICOMFILES]=dicomdir(['/Users/Happy/Documents/MATLAB/rGBM_Nec/data/case',num2str(case_num),'/']); %path of data directory
   % dicomdircopy(['/Users/Happy/Documents/MATLAB/rGBM_Nec/data/case',num2str(case_num)],DICOMDIRDATA,['/Users/Happy/Documents/MATLAB/rGBM_Nec/data/Restructured dataset/case',num2str(case_num),'/'],folderfields); %path of destination directory
    
   % [DICOMDIRDATA,NONDICOMFILES]=dicomdir(['/Users/Happy/Documents/Brain_MRI_data/case',num2str(case_num),'_',num2str(sub_case_num),'/']);
   % %path of data directory % Uncomment
   % dicomdircopy(['/Users/Happy/Documents/Brain_MRI_data/case',num2str(case_num),'_',num2str(sub_case_num),'/'],DICOMDIRDATA,['/Users/Happy/Documents/Brain_MRI_restructured1/case',num2str(case_num),'_',num2str(sub_case_num),'/'],folderfields);
   % %path of destination directory % Uncomment
%     
%    B = dir([mDir filesep folders(i).name]); B = B(3:end,:);
%    dDir = [mDir filesep folders(i).name filesep B([B.isdir]==1).name filesep];
%    
      B = dir([mDir filesep char(list{i,1})]); B = B(3:end,:);
   dDir = [mDir filesep char(list{i,1}) filesep B([B.isdir]==1).name filesep];
    [DICOMDIRDATA,NONDICOMFILES]=dicomdir(dDir); %path of data directory
    dicomdircopy_rs(dDir,DICOMDIRDATA, [sDir filesep],folderfields); %path of destination directory

end
    