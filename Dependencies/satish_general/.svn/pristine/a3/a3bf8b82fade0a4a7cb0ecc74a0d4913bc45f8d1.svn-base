function data = dce_masking(dataDir,MATfile,saveDir)

if ~exist('dataDir','var') || isempty(dataDir) 
    dataDir = uigetdir('W:/share/','Select folder with original DICOM data');
    if ~dataDir, error('Data directory required'); end
end
if ~exist('MATfile','var') || isempty(MATfile) 
    MATfile = uigetfile('Z:/InvivoMATFiles/BethIsrael/DCE/Uncorrected/*.mat','Select MAT file');
    if ~MATfile, error('MAT file required'); end
end
if ~exist('saveDir','var') || isempty(saveDir) 
    saveDir = uigetdir('Z:/InvivoMATFiles/BethIsrael/DCE/','Select folder to save files');
    if ~saveDir, error('Output directory required'); end
end

if ~strcmp(dataDir(end),'/')
    dataDir = [dataDir,'/'];
end
if ~strcmp(saveDir(end),'/')
    saveDir = [saveDir,'/'];
end

load(['Z:/InvivoMATFiles/BethIsrael/DCE/Uncorrected/',MATfile]);

nsl = 60;

templist = dir([dataDir,'*.dcm']);
file_names = cell(length(templist),1);
for i=1:length(file_names)
    file_names{i} = templist(i).name;
end

i=0;
ntp = length(file_names)/nsl;
fprintf('\nReading DCE images (timepoint 1): ');
for s=1:nsl
    i=i+1;
    temp(:,:,s) = double(dicomread([dataDir,file_names{i}]));
    fprintf('.');
end
dispimg3(temp);
flip = input('\nIs ordering base -> apex (0) or apex -> base (1)? ');

if ~flip
    i=0;    
    for t=1:ntp
        fprintf('\nReading DCE images (timepoint %d): ',t);
        for s=1:nsl
            i=i+1;
            MR(:,:,s,t)= double(dicomread([dataDir,file_names{i}]));
            fprintf('.');
        end
    end
else
    fprintf('\nFYI: DCE is apex -> base rather than base -> apex! Flipping ordering..');
    ntp = length(file_names)/nsl;
    for t=1:ntp
        i=t*60+1;
        fprintf('\nReading DCE images (timepoint %d): ',t);
        for s=1:nsl
            i=i-1;
            MR(:,:,s,t)= double(dicomread([dataDir,file_names{i}]));
            fprintf('.');
        end
    end
end

starting_d = data.nos(1);ending_d = data.nos(end);
for t=1:ntp
    k=0;
    for s=starting_d:ending_d
        k=k+1;
        volume(:,:,k,t)=MR(:,:,s,t).*mask(:,:,k);
    end
    dispimg3(volume(:,:,:,t));pause;
end

data.images = volume;

save([saveDir,MATfile],'data','mask');
close all;
fprintf('\n');
end
