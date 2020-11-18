function [data,mask] = create_volume_dce(maskDir,dataDir,saveDir)

addpath Z:/Code/matlabcode/general/

close all;
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
for i=1:length(file_names)
    img = dicomread([maskDir,file_names{i}]);
    boundaries(:,:,i)=double(img);
    boundaries_m(:,:,i) = boundaries(:,:,i)==max(straighten(boundaries(:,:,i)));
    fprintf('.');
end
dispimg3(boundaries_m);

templist = dir([dataDir,'*.dcm']);
file_names = cell(length(templist),1);
for i=1:length(file_names)
    file_names{i} = templist(i).name;
end

if ~flip
    i=0;
    ntp = ceil(length(file_names)/nsl);
    for t=1:ntp
        fprintf('\nReading DCE images (timepoint %d): ',t);
        for s=1:nsl
            i=i+1;
            MR(:,:,s,t)= double(dicomread([dataDir,file_names{i}]));
            MR_orig(:,:,s,t) = dicomread([dataDir,file_names{i}]);
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

fprintf('\n');

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
if length(starting_d:ending_d)~=size(boundaries_m,3); keyboard; end;

for i=1:size(boundaries_m,3)
    if size(boundaries_m(:,:,i),1)~=256
        mask(:,:,i) = imresize(double(boundaries_m(:,:,i)),size(MR(:,:,i,1)));
    else
        mask(:,:,i) = double(boundaries_m(:,:,i));
    end
    m = logical(~(imfill(logical(mask(:,:,i)),[1 1])));
    if sum(m(:))==0
        m = bwmorph(mask(:,:,i),'bridge');
        mask(:,:,i) = logical(~(imfill(logical(m),[1 1])));
        if sum(straighten(mask(:,:,i)))==0
            imwrite(rescale(double(m)),['C:\Temp\Segs\',num2str(i),'.tif']);
            keyboard;
            m = imread(['C:\Temp\Segs\',num2str(i),'.tif']);
            if size(m,1)~=256
                m = imresize(double(m),[256 256]);
            else
                m = double(m);
            end
            mask(:,:,i) = logical(~(imfill(logical(m),[1 1])));
        end
    else
        mask(:,:,i)=m;
    end
end

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

save([saveDir,data.name,'.mat'],'data','mask','MR_orig');
close all;
end