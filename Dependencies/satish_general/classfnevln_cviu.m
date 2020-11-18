function [stats] = classfnevln_cviu(res,gt,m,debug)
% function [stats] = classfnevln(res,gt,m,debug)

notgt = ~gt;
if nargin < 4, debug = 0;end;

% CVIU definitions
nfp= sum(straighten((res-gt)==1))/sum(straighten((m-gt)==0));
nfn = sum(straighten((gt-res)==1))/sum(straighten(gt==1));
sens = 1-nfn;
spec = 1-nfp;

% tparea = logical(res&gt);tp = sum(tparea(:));
% fparea = logical(res&notgt);fp = sum(fparea(:));
% tnarea = logical(((res==0)-m)&notgt);tn = sum(tnarea(:));
% fnarea = logical(((res==0)-m)&gt);fn = sum(fnarea(:));

if debug
    subplot(2,3,1);imdisp(res);title('Result');
    subplot(2,3,4);imdisp(gt);title('GT');
    subplot(2,3,2);imdisp(tparea);title('TP');
    subplot(2,3,3);imdisp(fparea);title('FP');
    subplot(2,3,5);imdisp(tnarea);title('TN');
    subplot(2,3,6);imdisp(fnarea);title('FN');
    pause;
end

% sens = tp/(tp+fn);
% spec = tn/(tn+fp);
% ss = tp/fp;
% ppv = tp/(tp+fp);
% acc = (tp+tn)/(tp+fp+fn+tn);

stats = [sens,spec];


end