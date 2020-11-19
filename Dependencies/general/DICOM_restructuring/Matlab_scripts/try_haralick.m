haralickfun=@haralick2mex;

I=imread('cameraman.tif');
%I=case16_2.standardized_volume_T1(:,:,1);
vol=double(I);
nharalicks=13;  % Number of Features 
bg=-1;   % Background
ws=5;    % Window Size
hardist=1;   % Distance in a window
harN=64;     % Maximum number of quantization level
volN=round(rescale_range(vol,0,harN-1));   % Quantizing an image
addedfeats=0;  % Feature counter index
% I=dicomread('G:\Users\Mahdi\Downloads\000013.dcm');
% 
% 
volfeats(:,:,addedfeats+(1:nharalicks))=haralickfun(volN,harN,ws,hardist,bg);
% volfeats_haralick=haralickfun(volN,harN,ws,hardist,bg);

featNames={'Entropy','Energy','Intertia','InDiffMom','Correlation','InfoMes1' ...
           'InfoMes2','Sum Ave','Sum Var','Sum Ent','Diff Ave','Diff Var','Diff Ent'};
       
% Features are:
% 1- Entropy
% 2- Energy
% 3- Intertia (some kind of contrast: sum_i sum_j {(i-j)^2 p_ij}) 
% 4- Inverse Difference Moment
% 5- Correlation
% 6- Information Measure of Correlation 1
% 7- Information Measure of Correlation 2
% 8- Sum Average
% 9- Sum Variance
% 10-Sum Entropy
% 11-Difference Average
% 12-Difference Variance
% 13-Difference Entropy

%--
figure (1)
subplot (3,5,1)
imagesc(vol); colormap gray; title ('Original'); axis image; axis off
for i=1:13
subplot (3,5,i+1)
imagesc(volfeats(:,:,i)); colormap gray
title (featNames{i})
axis image
axis off
end