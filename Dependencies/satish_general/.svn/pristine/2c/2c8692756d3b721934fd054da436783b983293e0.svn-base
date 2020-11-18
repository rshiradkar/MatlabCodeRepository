function [data,mask] = create_volume(maskDir,dataDir,saveDir)

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
    saveDir = uigetdir('Z:/InvivoMATFiles/BethIsrael/T2/','Select folder to save files');
    if ~saveDir, error('Output directory required'); end
end

starting = input('Enter starting slice number of volume: ');
ending = input('Enter ending slice number of volume: ');


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

for i=1:length(file_names)
    img = dicomread([maskDir,file_names{i}]);
    boundaries(:,:,i)=double(img);
    boundaries_m(:,:,i) = boundaries(:,:,i)==max(straighten(boundaries(:,:,i)));
end
dispimg3(boundaries_m);

templist = dir([dataDir,'*.dcm']);
file_names = cell(length(templist),1);
for i=1:length(file_names)
    file_names{i} = templist(i).name;
end

for i=starting:ending
    img = dicomread([dataDir,file_names{i}]);
    MR(:,:,i-starting+1)=double(img);
    MR_orig(:,:,i-starting+1)=img;
end

if size(MR,3)~=size(boundaries_m,3)
    error('Mismatch in number of slices segmented.'); 
end

for i=1:size(boundaries_m,3)
    if size(boundaries_m(:,:,i),1)~=512
        mask(:,:,i) = imresize(double(boundaries_m(:,:,i)),size(MR(:,:,i)));
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
            mask(:,:,i) = logical(~(imfill(logical(m),[1 1])));
        end
    else
        mask(:,:,i)=m;
    end
    volume(:,:,i) = MR(:,:,i).*mask(:,:,i);
    imdisp(volume(:,:,i));
end
dispimg3(volume);pause;

remove = input('Enter slice numbers to remove from beginning and end (in []): ');
data.nos = [starting:ending]; %#ok<NBRAK>
wanted = setdiff([1:size(volume,3)],remove);
remove = data.nos(remove);
data.nos = setdiff(data.nos,remove);
data.images = volume(:,:,wanted);
mask = mask(:,:,wanted);

data.name = input('Enter name of study (in quotes): ');

save([saveDir,data.name,'.mat'],'data','mask','MR_orig');

end