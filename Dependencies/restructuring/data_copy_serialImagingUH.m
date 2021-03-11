

close all;

addpath(genpath('C:\Matlab code from repo'));
addpath(genpath('C:\MatlabLibs\FileRename_29Nov2010'));
dDir = 'D:\UH Serial MRI\NEW\Redone';
wDir = 'D:\UH Serial MRI\NEW\redone_restructured';
patients = dir(dDir);
patients = patients(3:end,:);

%%
unusable = [];

for i = 1:length(patients)
    
    pDir = [dDir filesep patients(i).name filesep 'DICOM'];
    cd(pDir);
    dir2 = dir;
    cd(dir2(3).name);
    dir3 = dir;
    cd(dir3(3).name);
    dir4 = dir;
    cd(dir4(3).name);
    dir5 = dir;
    
    if length(dir5)>3
        sourceDir = pwd;
    else
        continue
    end
    
    files = dir(sourceDir); files = files(3:end,:);
    
    destDir = [wDir filesep patients(i).name];
    mkdir(destDir);
    
    for j = 1:length(files)
        %             disp(['processing - ' B{i,1}]);
        %[opens up a folder-picker window, point it to the parent folder which contains data you wish to have anonymized]
        %[function catalogs ALL DICOM information/tags present � no anonymization done at this step]
        fileDir = [sourceDir '\' files(j).name];
        filesDir = dir(fileDir);
        
        if length(filesDir)<8
            unusable = [unusable;j];
            continue
        end
        
        cd(fileDir)
        for k = 3:length(filesDir)
            FileRename(filesDir(k).name,[filesDir(k).name '.dcm']);
        end
        
        info = dicominfo([fileDir filesep filesDir(3).name]);
%         disp(info.SeriesDescription);
%         pause;
        
        
        try info.SeriesDescription
        catch
            disp('error and skipping');
            continue
        end
        
        
        %[function will parse above structure, delete all PHI tags, replace Pt ID with specified ID and rewrite all the data into a new folder, while maintaining organization. Organization is based on the 3rd argument above � this is the sequence of folders in which it will nest the data.]
        %[Around line 176 is where the tag removal happens. Additional tags can be specified here and �blanked�, similar to the ones already in there]
        %             destDir   = 'C:\Data\MRF_MRI\anon_data_prostate\Data restructured\';
        %         destDir = 'D:\UH_RP_cohort\';
        
        if length(cell2mat(regexpi(info.SeriesDescription,{'T2','AX'})))>=2
            doWrite = 1;
        elseif length(cell2mat(regexpi(info.SeriesDescription,{'T2','tse','tra'})))>=2
            doWrite = 1;
        elseif length(cell2mat(regexpi(info.SeriesDescription,{'ADC'})))==1
            doWrite = 1;
        else
            doWrite = 0;
        end
        
        if doWrite == 1
            dd = dicomdir(fileDir);
            dicomdircopy_rs(fileDir, dd, destDir,{'SeriesDescription','SeriesNumber'});
        end
    end
    
    clear sourceDir doWrite;
end

