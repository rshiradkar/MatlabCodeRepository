function [feats_t1,feats_t2] = computeTextureFeaturesROI(I_t1,I_t2,mask)

addpath(genpath('C:\Matlab code from repo'));

feats_t1=[]; feats_t2=[];

feats_t1 = [feats_t1 mean(I_t1(mask==1)) median(I_t1(mask==1)) skewness(I_t1(mask==1)) kurtosis(I_t1(mask==1))];
feats_t2 = [feats_t2 mean(I_t2(mask==1)) median(I_t2(mask==1)) skewness(I_t2(mask==1)) kurtosis(I_t2(mask==1))];
% 
% k = 3;
% W = 2*k;
% maskCollage = zeros(size(mask));
% maskCollage(W:(end-W+1),W:(end-W+1)) = 1;
% 
% temp = compute_CoLlAGe2D_editRS(I_t1, maskCollage, k);
% collageT1 = zeros(size(mask));
% collageT1(W:(end-W+1),W:(end-W+1)) = temp;
% 
% temp = compute_CoLlAGe2D_editRS(I_t2, maskCollage, k);
% collageT2 = zeros(size(mask));
% collageT2(W:(end-W+1),W:(end-W+1)) = temp;
% 
% feats_t1 = [feats_t1 mean(collageT1(mask==1))];
% feats_t2 = [feats_t2 mean(collageT2(mask==1))];


% T1_haralick = haralick2mexmt(double(rescale_range(I_t1,0,127)),128,5,2,0);
% T2_haralick = haralick2mexmt(double(rescale_range(I_t2,0,127)),128,5,2,0);
% 
% for i = 1:size(T1_haralick,3)
%     t1temp = T1_haralick(:,:,i);
%     feats_t1 = [feats_t1 mean(t1temp(mask==1))];
%     t2temp = T2_haralick(:,:,i);
%     feats_t2 = [feats_t2 mean(t2temp(mask==1))];
% end

