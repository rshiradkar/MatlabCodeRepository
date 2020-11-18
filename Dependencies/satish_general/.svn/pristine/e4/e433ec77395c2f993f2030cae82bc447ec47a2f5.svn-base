clear;clc;
cd ~satish/Code/matlabcode/general/
addpath ~satish/Code/matlabcode/inhomo_corrn/

% %For DCE
% dataset = '';
% load(['Z:\DCE\DCE+T2+Hist\',dataset,'\',dataset(1:3),'-DCE.mat']);
% load(['Z:\DCE\MICCAI\',dataset,'\slicecorrs.mat']);
% 
% %Correction on a 2D slice basis at each timepoint
% for j=1:length(slicecorrs.DCE)
%     sl = num2str(slicecorrs.DCE(j));
%     for i=1:7
%         temp(:,:,i) = inhomo_corrn(eval([dataset(1:3),'_d',sl,'(:,:,i)']));            
%     end
%     DCE.slice{j} = temp; clear temp;
%     %dispimg3(DCE.slice{j});pause;close all;
%     DCE.slno(j) = slicecorrs.DCE(j);
% end
% 
% save(['Z:\DCE\MICCAI\',dataset,'\',dataset],'DCE');
% 
% clear;

% load Z:\DCE\MICCAI09\alldata.mat T2r DCE
% 
% for i=1:length(T2r)
%     T2r(i).slice = inhomo_corrn(T2r(i).slice);
%     for j=1:7
%         DCE(i).slice(:,:,j) = inhomo_corrn(DCE(i).slice(:,:,j));
%     end
% end
% 
% save Z:\DCE\MICCAI09\alldata T2r DCE -append

% % For T2
datasets = {'MCL246'};
for d= 1:length(datasets)
    load(['~satish/InvivoMATFiles/BethIsrael/T2/Uncorrected/',datasets{d},'.mat']);
    data.images = inhomo_corrn(data.images,'~satish/Code/matlabcode/inhomo_corrn/Linux/64-bit/BiasCorrector');
    save(['~satish/InvivoMATFiles/BethIsrael/T2/',datasets{d},'.mat'],'data','mask');
    clear data mask
end

% For DCE
% datasets = {'LOR109'};
% for d= 1:length(datasets)
    % load(['Z:/InvivoMATFiles/BethIsrael/DCE/Uncorrected/',datasets{d},'.mat']);
    % for t=1:7
        % data.images(:,:,:,t) = inhomo_corrn(data.images(:,:,:,t),'Z:/Code/matlabcode/inhomo_corrn/Windows/64-bit/BiasCorrector');
    % end
    % save(['Z:/InvivoMATFiles/BethIsrael/DCE/',datasets{d},'.mat'],'data','mask');
    % clear data mask
% end



% For HUM
% clear;close all;
% datasets = {'BER410','COH833','CUN487','LOR109','MCG791','RUD740','SER941','THE829','THO587','QUA374','TUP669','VOC007'};
% for d= 1:length(datasets)
%     load(['Z:\InvivoMATFiles\BethIsrael\Unsegmented\',datasets{d},'.mat']);
%     disp(datasets{d});
%     notok = 0;sig=7;
%     while ~notok
%         im = biasCorrect_HUM(data.images,ones(size(data.images)),sig,1);
%         notok = input('OK? ');
%         if ~notok, sig=sig+1;close all;end
%     end
%     disp('Saving..');
%     data.images = im;
%     save(['Z:\InvivoMATFiles\BethIsrael\',datasets{d},'.mat'],'data');
% end