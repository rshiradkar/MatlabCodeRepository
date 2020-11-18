function [stats] = classfnevln_ns(res,gt,m,debug)
% function [stats] = classfnevln(res,gt,m,debug)

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

stats = [tp,fp,tn,fn];


end