function outVol = padVolume(inVol,sz)
% pads the inVol such that both the rows and columns are of the same size
% which is the max of the either. If sz is specified, it pads the rows and
% columns to that specific size
% - Rakesh 02/09/15

[nRows,nCols,nSlices] = size(inVol);
if nargin < 2
    sz = max(nRows,nCols);
end

rDiff = sz - nRows;
cDiff = sz - nCols;

outVol = cat(1,inVol,zeros(rDiff,nCols,nSlices));
outVol = cat(2,outVol,zeros(sz,cDiff,nSlices));

