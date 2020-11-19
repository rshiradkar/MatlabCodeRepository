%% 

addpath(genpath('C:\Matlab code from repo'));
id = '28184';

dataDir = ['C:\Data\UH_Prostate_new from Rod\' id '\ElastixRegistration\Data\'];
info = mha_read_header([dataDir 'planMR_crop.mha']);
MR = mha_read_volume([dataDir 'planMR_crop.mha']);

spacing = 25;

V = generateGridVolume(size(MR,1),size(MR,2),size(MR,3),spacing);

mha_write_volume([dataDir 'planMR_crop_grid.mha'],int16(V*2^16),info.PixelDimensions,info.Offset,info.TransformMatrix);