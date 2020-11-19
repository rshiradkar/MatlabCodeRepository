function [clipped,topclipval,bottomclipval] = dataclip(indata,toppctile,bottompctile)
% clipped = dataclip(indata,toppctile,bottompctile)
% e.g. clipped = dataclip(indata,.99,.01)

if nargin<3, bottompctile=0; end
if toppctile>1 || toppctile<0 || bottompctile>1 || bottompctile<0,
    error('percentiles out of range [0,1]'); end

clipped=sort(indata(:));
topclipval=clipped(round(numel(indata)*toppctile));
bottomclipval=clipped(round(numel(indata)*bottompctile)+1);
clipped=indata;
clipped(indata>topclipval)=topclipval;
clipped(indata<bottomclipval)=bottomclipval;
