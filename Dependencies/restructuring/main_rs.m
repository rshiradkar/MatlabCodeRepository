            
dDir = pwd;
cd('C:\Data\MRF_MRI\anon_data_prostate\');

sourceDir = uigetdir('.','Choose a DICOM root directory');
files = dir(sourceDir); files = files(3:end,:);
cd(dDir);

for i = 1:length(files)
%[opens up a folder-picker window, point it to the parent folder which contains data you wish to have anonymized]
            %[function catalogs ALL DICOM information/tags present � no anonymization done at this step]
            fileDir = [sourceDir '\' files(i).name];
            dd = dicomdir(fileDir);
            
           
%[function will parse above structure, delete all PHI tags, replace Pt ID with specified ID and rewrite all the data into a new folder, while maintaining organization. Organization is based on the 3rd argument above � this is the sequence of folders in which it will nest the data.]
            %[Around line 176 is where the tag removal happens. Additional tags can be specified here and �blanked�, similar to the ones already in there]
%             destDir   = 'C:\Data\MRF_MRI\anon_data_prostate\Data restructured\';
destDir = 'D:\UH_RP_cohort\';

            dicomdircopy_rs(fileDir, dd, destDir,{'PatientID','StudyDate','SeriesDescription','SeriesNumber'});
end
        