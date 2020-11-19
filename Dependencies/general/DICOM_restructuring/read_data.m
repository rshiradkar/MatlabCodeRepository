%**** Read raw data and restructure ******%



%folderfields={'PatientName.FamilyName','StudyDate','StudyDescription','SeriesDescription','SeriesNumber','SeriesTime'};
%change
folderfields={'PatientName.FamilyName','StudyDate','StudyDescription','SeriesDescription','SeriesNumber'};
n=140; % number of cases
for case_n=1:n
    prompt = 'What is the case number? ';
    case_num = input(prompt);
  %  prompt = 'What is the sub-case number? '; %Uncomment
  %  sub_case_num = input(prompt);    %Uncomment
   % [DICOMDIRDATA,NONDICOMFILES]=dicomdir(['/Users/Happy/Documents/MATLAB/rGBM_Nec/data/case',num2str(case_num),'/']); %path of data directory
   % dicomdircopy(['/Users/Happy/Documents/MATLAB/rGBM_Nec/data/case',num2str(case_num)],DICOMDIRDATA,['/Users/Happy/Documents/MATLAB/rGBM_Nec/data/Restructured dataset/case',num2str(case_num),'/'],folderfields); %path of destination directory
    
   % [DICOMDIRDATA,NONDICOMFILES]=dicomdir(['/Users/Happy/Documents/Brain_MRI_data/case',num2str(case_num),'_',num2str(sub_case_num),'/']);
   % %path of data directory % Uncomment
   % dicomdircopy(['/Users/Happy/Documents/Brain_MRI_data/case',num2str(case_num),'_',num2str(sub_case_num),'/'],DICOMDIRDATA,['/Users/Happy/Documents/Brain_MRI_restructured1/case',num2str(case_num),'_',num2str(sub_case_num),'/'],folderfields);
   % %path of destination directory % Uncomment
    
    [DICOMDIRDATA,NONDICOMFILES]=dicomdir(['/Users/Happy/Documents/Brain_MRI_data/case',num2str(case_num),'/']); %path of data directory
    dicomdircopy(['/Users/Happy/Documents/Brain_MRI_data/case',num2str(case_num),'/'],DICOMDIRDATA,['/Users/Happy/Documents/Brain_MRI_restructured1/case',num2str(case_num),'/'],folderfields); %path of destination directory




end
    