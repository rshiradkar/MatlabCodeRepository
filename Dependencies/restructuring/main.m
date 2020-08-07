dDir = pwd;
cd('/mnt/nexsan-ksl/ccipd/data/MtSinai_Prostate_MRI/Progressive Urologics Rastinehad Image Data/LIJ Data Set Anonomyzed 7 2015/');
sourceDir = uigetdir('.','Choose a DICOM root directory');
cd(dDir);

%[opens up a folder-picker window, point it to the parent folder which contains data you wish to have anonymized]
%[function catalogs ALL DICOM information/tags present � no anonymization done at this step]
dd = dicomdir(sourceDir);


%[function will parse above structure, delete all PHI tags, replace Pt ID with specified ID and rewrite all the data into a new folder, while maintaining organization. Organization is based on the 3rd argument above � this is the sequence of folders in which it will nest the data.]
%[Around line 176 is where the tag removal happens. Additional tags can be specified here and �blanked�, similar to the ones already in there]
destDir   = '/scratch/users/rxs558/';
dicomdircopy(sourceDir, dd, destDir,{'PatientName.FamilyName','StudyDate','SeriesDescription','SeriesNumber'});
