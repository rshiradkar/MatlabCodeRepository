function [data,mask] = getdicomstuff(dataDir)

close all;

if ~exist('dataDir','var') || isempty(dataDir) 
    dataDir = uigetdir('','Select folder with original DICOM data');
    if ~dataDir, error('Data directory required'); end
end

if ~strcmp(dataDir(end),'/')
    dataDir = [dataDir,'/'];
end

templist = dir([dataDir,'*.dcm']);
file_names = cell(length(templist),1);
for i=1:length(file_names)
    file_names{i} = templist(i).name;
end

for i=starting:ending
    img = dicomread([dataDir,file_names{i}]);
    data(:,:,i-starting+1)=double(img);
end

if size(data,3)~=size(boundaries_m,3)
    error('Mismatch in number of slices segmented.'); 
end

for i=1:size(boundaries_m,3)
    mask(:,:,i) = imresize(double(boundaries_m(:,:,i)),[512 512]);
    mask(:,:,i) = logical(~(imfill(logical(mask(:,:,i)),[1 1])));
    volume(:,:,i) = data(:,:,i).*mask(:,:,i);
end
dispimg3(volume);pause;

data.images = volume;
data.name = input('Enter name of study (in quotes): ');
data.nos = [starting:ending]; %#ok<NBRAK>
save([saveDir,data.name,'.mat'],'data','mask');

end