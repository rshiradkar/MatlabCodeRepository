
addpath Z:/Code/matlabcode/general/

clear; close all;
if ~exist('maskDir','var') || isempty(maskDir)
    maskDir = uigetdir('W:/share/','Select folder containing segmented files');
    if ~maskDir, error('Segmentations directory required'); end
end
if ~exist('dataDir','var') || isempty(dataDir) 
    dataDir = uigetdir('W:/share/','Select folder with original DICOM data');
    if ~dataDir, error('Data directory required'); end
end
if ~exist('saveDir','var') || isempty(saveDir) 
    saveDir = uigetdir('Z:/InvivoMATFiles/BethIsrael/DCE/','Select folder to save files');
    if ~saveDir, error('Output directory required'); end
end

starting = input('Enter starting slice number of volume: ');
ending = input('Enter ending slice number of volume: ');
nsl = input('Enter number of slices in ONE DCE timepoint: ');

if starting>ending, flip=1; else flip=0; end;

if ~strcmp(maskDir(end),'/')
    maskDir = [maskDir,'/'];
end
if ~strcmp(dataDir(end),'/')
    dataDir = [dataDir,'/'];
end
if ~strcmp(saveDir(end),'/')
    saveDir = [saveDir,'/'];
end

templist = dir(maskDir);
templist = templist(3:end);
file_names = cell(length(templist),1);
for i=1:length(file_names)
    file_names{i} = templist(i).name;
end

fprintf('\nReading segmentation info:');
for i=1:length(file_names)-1
    img = imread([maskDir,file_names{i}]);
    mask(:,:,i)=logical(img(:,:,1));
end
dispimg3(mask);

templist = dir([dataDir,'*.dcm']);
file_names = cell(length(templist),1);
for i=1:length(file_names)
    file_names{i} = templist(i).name;
end

if ~flip
    i=0;
    ntp = length(file_names)/nsl;
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
        i=t*nsl+1;
        fprintf('\nReading DCE images (timepoint %d): ',t);
        for s=1:nsl
            i=i-1;
            MR(:,:,s,t)= double(dicomread([dataDir,file_names{i}]));
            fprintf('.');
        end
    end
end

if fix(starting/nsl) ~= fix(ending/nsl)
    fprintf('\nNote: Last segmented slice is last slice of timepoint.\n');
end
utp = fix(starting/nsl);
if ~flip
    starting_d = starting-utp*nsl;
    ending_d = ending-utp*nsl;
else
    starting_d = 61-(starting-utp*nsl);
    ending_d = 61-(ending-utp*nsl);
end
if length(starting_d:ending_d)~=size(mask,3); keyboard; end;

for t=1:ntp
    k=0;
    for s=starting_d:ending_d
        k=k+1;
        volume(:,:,k,t)=MR(:,:,s,t).*mask(:,:,k);
    end
    dispimg3(volume(:,:,:,t));pause;
end

remove = input('Enter slice numbers to remove from beginning and end (in []): ');
data.nos = [starting_d:ending_d]; %#ok<NBRAK>
wanted = setdiff([1:size(volume,3)],remove);
remove = data.nos(remove);
data.nos = setdiff(data.nos,remove);
for i=1:ntp
    data.images(:,:,:,i) = volume(:,:,wanted,i);
end
mask = mask(:,:,wanted);
data.name = input('Enter name of study (in quotes): ');
save([saveDir,data.name,'.mat'],'data','mask');
close all;