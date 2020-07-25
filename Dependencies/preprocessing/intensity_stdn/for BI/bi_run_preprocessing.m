% Noise correction, standardization of T2, DCE, ADC
% For SIIM 2013/JDI

% Paths
clear;clc;close all;
addpath D:/lab_matlab_code/general/ D:/lab_matlab_code/images/
addpath(genpath('D:/lab_matlab_code/preprocessing/'));
dropfolder = 'C:\Users\Satish\Dropbox';

%% Noise correction for T2, DCE, ADC
load([dropfolder,'/WorkfromHome/SIIM2013/unstddata-21-Jun-2011.mat'],'data');
setnames = unique({data(:).name});
for s=1:length(setnames)
    slices = find(strcmp({data(:).name},setnames{s}));
    [nx,ny] = size(data(slices(1)).t2);
    vol = round(reshape([data(slices).adc],nx,ny,length(slices)));
    whl = reshape([data(slices).whole],nx,ny,length(slices));
    vol = cat(3,zeros(nx,ny),vol,zeros(nx,ny));
    filt_vol = anisodiff3D(vol,10,3/44,20,2,[0.28;0.28;2.2]);
    filt_vol = filt_vol(:,:,2:end-1);if size(filt_vol,3) ~= length(slices), error('Slice mismatch'); end;
    filt_vol = filt_vol.*whl;
    plotdist(vol,'r');hold on;plotdist(filt_vol,'b');legend({'non-filt','filt'});hold off;
    dispimg3(vol);dispimg3(filt_vol);
    pause;close all;
end

%% BIDMC T2

stdizeddata = data;
setnames = unique({data(:).name});
if ~exist('std','var')
    stddatasetname = 'COH833';
    stdimnos = find(strcmp({data(:).name},stddatasetname));
    [nx,ny] = size(data(stdimnos(1)).t2);
    std = reshape([data(stdimnos).t2],nx,ny,length(stdimnos));
    stdcancermasks = reshape([data(stdimnos).gt],nx,ny,length(stdimnos));    
    setnames = setdiff(setnames,stddatasetname);
    %setnames = setdiff(setnames,{'COH833','BER410','CLA024','DON812','DON924','HAR345','LOR109','MCC128','RUD740','THE829','THO587','TUP669','VOC007','HIN618','ROB365'});
else
    [nx,ny] = size(std(:,:,1));
end

%Do only topclip, with 5*std (first 15), 4*std (add 9)
%Doing botclip causes the images to become too 'dark'
%Standardize ALL datasets regardless of whether it seems histograms "might" align
stdn_options.numstdtopclip = 5;
stdn_options.zeroval = 0;
stdn_options.dorescale = true;
for s=1:length(setnames)
    slices = find(strcmp({data(:).name},setnames{s}));
    test = round(reshape([data(slices).t2],nx,ny,length(slices)));
    testcancermasks = reshape([data(slices).gt],nx,ny,length(slices));
    disp(setnames{s});   
    stdn_options.temcancermasks = stdcancermasks;
    stdn_options.incancermasks = testcancermasks;    
    [testresult,teststandmap{s}] = int_stdn_landmarks(test,std,stdn_options);    
    %[testresult,teststandmap{s}] = int_stdn_landmarks(test,std);    
    for i=1:length(slices)
        stdizeddata(slices(i)).t2 = testresult(:,:,i);
    end
    close all;fprintf('\n');
end
break;

% first15_standmaps = teststandmap; first15_donesets = setnames;
% save ~/T2+DCE+ADC/t2stdn.mat std stdcancermasks stddatasetname first15_standmaps first15_donesets
% clear data; data = stdizeddata;
% save ~/T2+DCE+ADC/t2std-20-Feb-2012.mat data

% add9_standmaps = teststandmap; add9_donesets = setnames;
% save ~/T2+DCE+ADC/t2stdn.mat std add9_standmaps add9_donesets -append
% clear data; data = stdizeddata;
% save ~/T2+DCE+ADC/addTD-t2std-20-Feb-2012.mat data

%% BIDMC ADC
load ~/T2+DCE+ADC/TDA-t2std-20-Feb-2012.mat data %Stdized T2, non-standard ADC,DCE --> Saved as ~/T2+DCE+ADC/TDA-t2adcstd-20-Feb-2012.mat
stdizeddata = data;
setnames = unique({data(:).name});
if ~exist('std','var')
    stddatasetname = 'COH833';
    stdimnos = find(strcmp({data(:).name},stddatasetname));
    [nx,ny] = size(data(stdimnos(1)).adc);
    std = reshape([data(stdimnos).adc],nx,ny,length(stdimnos));
    if ~isempty(find(std(:)<0)),
        disp('Standard dataset has negative values!');
        std(std<0) = 0; %correcting for negative values
    end
    stdcancermasks = reshape([data(stdimnos).gt],nx,ny,length(stdimnos));    
    setnames = setdiff(setnames,stddatasetname);
    %setnames = setdiff(setnames,{'COH833','BER410','CLA024','DON812','DON924','HAR345','LOR109','MCC128','RUD740','THE829','THO587','TUP669','VOC007','HIN618','ROB365'});
else
    [nx,ny] = size(std(:,:,1));
end

%Notes:
%Standardizing VOC007 causes histogram to get very warped, so left as is (no standardization)
%Clipping the extreme values could be run until no extremes remain. Unsure
%if this a correct thing to do - for now only one clipping done, both top
%and bottom clipped
%Standardize ALL datasets regardless of whether it seems histograms "might" align
for s=1:length(setnames)
    slices = find(strcmp({data(:).name},setnames{s}));
    test = round(reshape([data(slices).adc],nx,ny,length(slices)));
    if ~isempty(find(test(:)<0)),
        disp('Dataset has negative values! Correcting..');
        test(test<0) = 1; %correcting for negative values
    end
    testcancermasks = reshape([data(slices).gt],nx,ny,length(slices));
    disp(setnames{s});    
    [testresult,teststandmap{s}] = int_stdn_landmarks(test,std,testcancermasks,stdcancermasks,6,6);    
    %[testresult,teststandmap{s}] = int_stdn_landmarks(test,std);    
    for i=1:length(slices)
        stdizeddata(slices(i)).adc = testresult(:,:,i);
    end
    close all;fprintf('\n');
end
break;

% first15_standmaps = teststandmap; first15_donesets = setnames;
% save ~/T2+DCE+ADC/adcstdn.mat std stdcancermasks stddatasetname first15_standmaps first15_donesets
% clear data; data = stdizeddata;
% save ~/T2+DCE+ADC/TDA-t2adcstd-20-Feb-2012.mat data

%% BIDMC DCE
% load([setpaths,'T2+DCE+ADC/TDA-t2adcstd-20-Feb-2012.mat'],'data'); %--> saved as ~/T2+DCE+ADC/allTDAdata.mat
load([setpaths,'T2+DCE+ADC/dcestdn.mat'],'std','stdcancermasks','stddatasetname');
load([setpaths,'T2+DCE+ADC/addTD-t2std-20-Feb-2012.mat'],'data'); %--> saved as ~/T2+DCE+ADC/addTDdata.mat
stdizeddata = data;
setnames = unique({data(:).name});
if ~exist('std','var')
    stddatasetname = 'COH833';
    stdimnos = find(strcmp({data(:).name},stddatasetname));
    [nx,ny,ntp] = size(data(stdimnos(1)).dce);
    std = reshape([data(stdimnos).dce],nx,ny,length(stdimnos),ntp);
    stdcancermasks = reshape([data(stdimnos).gt],nx,ny,length(stdimnos));    
    setnames = setdiff(setnames,stddatasetname);
    %setnames = setdiff(setnames,{'COH833','BER410','CLA024','DON812','DON924','HAR345','LOR109','MCC128','RUD740','THE829','THO587','TUP669','VOC007','HIN618','ROB365'});
else
    [nx,ny,ntp] = size(std(:,:,1,:));
end

%Do only topclip, with 5*std (first 15), 4*std (add 9)
%Doing botclip causes the images to become too 'dark'
%Standardize ALL datasets regardless of whether it seems histograms "might" align
for s=1:length(setnames)
    slices = find(strcmp({data(:).name},setnames{s}));
    test = round(reshape([data(slices).dce],nx,ny,length(slices),ntp));
    testcancermasks = reshape([data(slices).gt],nx,ny,length(slices));
    disp(setnames{s});
    for t=1:ntp
        disp(['TP=',num2str(t)]);
        [testresult(:,:,:,t),teststandmap{s,t}] = int_stdn_landmarks(test(:,:,:,t),std(:,:,:,t),testcancermasks,stdcancermasks,5);    
        %[testresult,teststandmap{s}] = int_stdn_landmarks(test,std);   
        close all;
    end        
    for i=1:length(slices)
        stdizeddata(slices(i)).dce = squeeze(testresult(:,:,i,:)); 
    end
    fprintf('\n');   
    clear testresult
end
break;

% first15_standmaps = teststandmap; first15_donesets = setnames;
% save([setpaths,'T2+DCE+ADC/dcestdn.mat'],'std','stdcancermasks','stddatasetname','first15_standmaps','first15_donesets');
% clear data; data = stdizeddata;
% save([setpaths,'T2+DCE+ADC/allTDAdata.mat'],'data');

% add9_standmaps = teststandmap; add9_donesets = setnames;
% save([setpaths,'T2+DCE+ADC/dcestdn.mat'],'add9_standmaps','add9_donesets','-append');
% clear data; data = stdizeddata;
% save([setpaths,'T2+DCE+ADC/addTDdata.mat'],'data');

%% Checking histograms - T2
donesets = first15_donesets; %add9_donesets%; ; setnames; 
stdizeddata = data;
[nx,ny] = size(stdizeddata(1).t2);
% donesets = {'BER410','CLA024','DON812','DON924','HAR345','LOR109','MCC128','RUD740','THE829','THO587','TUP669','VOC007','QUA374'};
% donesets = {'CDH001','CDH005','CDH006','CDH007','CDH008','THIRD1','THIRD2','THIRD3'};
% donesets = {'CLA024','RUD740','THE829','THO587','TUP669','VOC007'};
cols = {[0.75 0.75 0.75],[1 0 1],[0 1 1],[1 0 0],[0 1 0],[0 0 1],[0.5 0.5 0.5],[0.5 0 0.5],[0 0.5 0.5],[0.5 0.5 1],[0.5 0 0],[0 1 0.5],[0 0.5 0],[1 0.5 0.5]};
figure;
for s=1:length(donesets)
    slices = find(strcmp({stdizeddata(:).name},donesets{s}));
    done = reshape([stdizeddata(slices).t2],nx,ny,length(slices));
    [stdcnts,stdwhtcnted] = count(done(:));
    stdcnts = stdcnts(2:end);stdwhtcnted = stdwhtcnted(2:end);      %dropping graylevel = 0, and corresponding count
    k = fspecial('average',[1 25]);
    stdsmoothhist = conv(stdcnts/sum(stdcnts),k,'same');    
    p = plot(stdwhtcnted,stdsmoothhist);title('Smoothed histogram of T2 done datasets');hold on;
    set(p,'Color',cols{s},'LineWidth',2);
end
% stdimnos = find(strcmp({stdizeddata(:).name},'COH833'));
% std = reshape([stdizeddata(stdimnos).t2],nx,ny,length(stdimnos));
[stdcnts,stdwhtcnted] = count(std(:));
stdcnts = stdcnts(2:end);stdwhtcnted = stdwhtcnted(2:end);      %dropping graylevel = 0, and corresponding count
k = fspecial('average',[1 25]);
stdsmoothhist = conv(stdcnts/sum(stdcnts),k,'same');
p = plot(stdwhtcnted,stdsmoothhist);hold on;
set(p,'Color',[0 0 0],'LineWidth',2.5);

%% Checking histograms - ADC
donesets = first15_donesets; %setnames;
stdizeddata = data;
[nx,ny] = size(stdizeddata(1).adc);
cols = {[0.75 0.75 0.75],[1 0 1],[0 1 1],[1 0 0],[0 1 0],[0 0 1],[0.5 0.5 0.5],[0.5 0 0.5],[0 0.5 0.5],[0.5 0.5 1],[0.5 0 0],[0 1 0.5],[0 0.5 0],[1 0.5 0.5]};
figure;
for s=1:length(donesets)
    slices = find(strcmp({stdizeddata(:).name},donesets{s}));
    done = reshape([stdizeddata(slices).adc],nx,ny,length(slices));
    [stdcnts,stdwhtcnted] = count(done(done~=0));
    stdcnts = stdcnts(2:end);stdwhtcnted = stdwhtcnted(2:end);      %dropping graylevel = 0, and corresponding count
    k = fspecial('average',[1 25]);
    stdsmoothhist = conv(stdcnts/sum(stdcnts),k,'same');    
    p = plot(stdwhtcnted,stdsmoothhist);title('Smoothed histogram of ADC done datasets');hold on;
    set(p,'Color',cols{s},'LineWidth',2);
end
% stdimnos = find(strcmp({stdizeddata(:).name},'COH833'));
% [nx,ny] = size(stdizeddata(stdimnos(1)).adc);
% std = reshape([stdizeddata(stdimnos).t2],nx,ny,length(stdimnos));
[stdcnts,stdwhtcnted] = count(std(:));
stdcnts = stdcnts(2:end);stdwhtcnted = stdwhtcnted(2:end);      %dropping graylevel = 0, and corresponding count
k = fspecial('average',[1 25]);
stdsmoothhist = conv(stdcnts/sum(stdcnts),k,'same');
p = plot(stdwhtcnted,stdsmoothhist);hold on;
set(p,'Color',[0 0 0],'LineWidth',2.5);

%% Checking histograms - DCE
donesets = first15_donesets; %add9_donesets%; setnames; 
stdizeddata = data;
[nx,ny,ntp] = size(stdizeddata(1).dce);
cols = {[0.75 0.75 0.75],[1 0 1],[0 1 1],[1 0 0],[0 1 0],[0 0 1],[0.5 0.5 0.5],[0.5 0 0.5],[0 0.5 0.5],[0.5 0.5 1],[0.5 0 0],[0 1 0.5],[0 0.5 0],[1 0.5 0.5]};

for t=1:ntp
    tpfig(t) = figure;
    figure(tpfig(t));
    for s=1:length(donesets)
        slices = find(strcmp({stdizeddata(:).name},donesets{s}));
        done = reshape([stdizeddata(slices).dce],nx,ny,length(slices),ntp);
        [stdcnts,stdwhtcnted] = count(done(:,:,:,t));
        stdcnts = stdcnts(2:end);stdwhtcnted = stdwhtcnted(2:end);      %dropping graylevel = 0, and corresponding count
        k = fspecial('average',[1 25]);
        stdsmoothhist = conv(stdcnts/sum(stdcnts),k,'same');    
        p = plot(stdwhtcnted,stdsmoothhist);title(['Smoothed histogram of DCE done datasets, TP=',num2str(t)]);hold on;  
        set(p,'Color',cols{s},'LineWidth',2);    
    end
    % stdimnos = find(strcmp({stdizeddata(:).name},'COH833'));
    % std = reshape([stdizeddata(stdimnos).t2],nx,ny,length(stdimnos));
    [stdcnts,stdwhtcnted] = count(std(:,:,:,t));
    stdcnts = stdcnts(2:end);stdwhtcnted = stdwhtcnted(2:end);      %dropping graylevel = 0, and corresponding count
    k = fspecial('average',[1 25]);
    stdsmoothhist = conv(stdcnts/sum(stdcnts),k,'same');
    p = plot(stdwhtcnted,stdsmoothhist);hold on;
    set(p,'Color',[0 0 0],'LineWidth',2.5);
end
    
%% Seeing where the GT is

close all;
for i=1:length(stdizeddata)
%for i=[1,3,7,8,10,11,16,17,18,24,26,28,30,33,38,41,42,43,46,48,51,52]
    if i>1 && ~strcmp(stdizeddata(i).name,stdizeddata(i-1).name), pause;close all; end
    figure;    
    subplot(1,1,1);imdisp(stdizeddata(i).t2);hold on;
    %subplot(1,3,2);imdisp(stdizeddata(i).dce(:,:,5));hold on;
    %subplot(1,3,3);imdisp(stdizeddata(i).adc);hold on;
    B=bwboundaries(stdizeddata(i).gt);
    for k=1:length(B),
        boundary = B{k};
        for j=1:1
            subplot(1,1,j);plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
        end
    end
    frac = num2str(sum(stdizeddata(i).gt(:))/sum(stdizeddata(i).whole(:)));
    title([num2str(i),' [',stdizeddata(i).name,'-',num2str(stdizeddata(i).slno),']',...
        '(',num2str(sum(stdizeddata(i).gt(:))),'/',num2str(sum(stdizeddata(i).whole(:))),'=',frac,')']);
    %pause;
end 

%% Alignment of non-standardized histograms

% notdone = {'HIN618','ROB365'};
notdone = {'THIRD1'};
for s=1:length(notdone)
    slices = find(strcmp({stdizeddata(:).name},notdone{s}));
    done = reshape([stdizeddata(slices).img],nx,ny,length(slices));
    %done = round(rescale_range(done,0,max(std(:))));
    [stdcnts,stdwhtcnted] = count(done(:));
    stdcnts = stdcnts(2:end);stdwhtcnted = stdwhtcnted(2:end);      %dropping graylevel = 0, and corresponding count
    k = fspecial('average',[1 25]);
    stdsmoothhist = conv(stdcnts,k,'same');
    plot(stdwhtcnted,stdsmoothhist,'k');title('Smoothed histograms');hold on;
end

