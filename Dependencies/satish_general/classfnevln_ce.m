function [stats] = classfnevln_ce(res,gt,m,debug)
% function [stats] = classfnevln_ce(res,gt,m,debug)
% stats = [sens,spec,ppv,acc]

notgt = (m-gt)==1;
if nargin < 4, debug = 0;end;

tparea = logical(res&gt);tp = sum(tparea(:));
fparea = logical(res&notgt);fp = sum(fparea(:));
tnarea = logical(~res&notgt);tn = sum(tnarea(:));
fnarea = logical(~res&gt);fn = sum(fnarea(:));

if debug
    subplot(2,3,1);imdisp(res);title('Result');
    subplot(2,3,4);imdisp(gt);title('GT');
    subplot(2,3,2);imdisp(tparea);title('TP');
    subplot(2,3,3);imdisp(fparea);title('FP');
    subplot(2,3,5);imdisp(tnarea);title('TN');
    subplot(2,3,6);imdisp(fnarea);title('FN');
    pause;
end

sens = tp/(tp+fn);
spec = tn/(tn+fp);
ppv = tp/(tp+fp);
if tp <= 0.2*sum(gt(:))
    acc = tp/(tp+fp+fn+tn);
else
    acc = (tp+tn)/(tp+fp+fn+tn);
end

if (sum(tp+fp)==0)
    ppv=0;acc=0;
end

stats = [sens,spec,ppv,acc];


end