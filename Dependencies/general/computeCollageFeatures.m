function featsAll = computeCollageFeatures(I,mask)

addpath(genpath('C:\Matlab code from repo'));

I = imfilter(I,fspecial('average'));

k = 3;
W = 2*k;
maskCollage = zeros(size(I));
maskCollage(W:(end-W+1),W:(end-W+1)) = 1;
collage = zeros(size(I,1),size(I,2),13);

temp = compute_CoLlAGe2D_all_editRS(I, maskCollage, k);

for i = 1:13
    collage(W:(end-W+1),W:(end-W+1),i) = temp(:,:,i);
end

[r,c] = find(mask==1);
featsAll = zeros(length(r),size(collage,3));
for i = 1:length(r)
    featsAll(i,:) = reshape(collage(r(i),c(i),:),1,[]);
end