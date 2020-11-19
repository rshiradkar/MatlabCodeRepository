function featsAll = computeTextureFeatures(I,mask)

addpath(genpath('C:\Matlab code from repo'));
I = double(I);
% I = medfilt2(I);
grayfeats = [];

% intensities
grayfeats(:,:,1) = I;
I = imfilter(I,fspecial('average'));

% graylevel features
grayfeats(:,:,2:5) = grayfilts2(I,3);

% gradient features
grayfeats(:,:,6:18) = gradfilts2(I);



% collage
disp('Computing collage features...');
k = 3;
W = 2*k;
maskCollage = zeros(size(I));
maskCollage(W:(end-W+1),W:(end-W+1)) = 1;

temp = compute_CoLlAGe2D_editRS(I, maskCollage, k,1);
collage = zeros(size(I));
collage(W:(end-W+1),W:(end-W+1)) = temp;

% haralick
disp('Computing haralick features...');
nHistBins = 128;
dist = 1;
bg = -1;
harFeats = [];
for i = 1:2:5
    winSize = 2*i+1;
    harFeats = cat(3,harFeats,haralick2mexmt(double(rescale_range(I,0,nHistBins-1)),nHistBins,winSize,dist,bg));
end

% gabor
disp('Computing gabor features...');
b=1; psi = 0; gamma = 1; gbFeats = [];
for gaborWavelength = 1.0 : 1.0 : 5.0;
    gaborOrientation =  0.25 ;
    [gb_c,gb_s]=gabor2dkerns(gaborOrientation,gaborWavelength,b,psi,gamma);
    gbKernel = sqrt(gb_c.^2 + gb_s.^2);
    temp = conv2(im2double(I),gbKernel,'same');
    gbFeats = cat(3,gbFeats,rescale(temp));
end

feats = cat(3,grayfeats,collage,harFeats,gbFeats);

[r,c] = find(mask==1);
featsAll = zeros(length(r),size(feats,3));
for i = 1:length(r)
    featsAll(i,:) = reshape(feats(r(i),c(i),:),1,[]);
end
