function Iout= rescale_range_rs(I,rangedata)
% RESCALE_RANGE Rescale data into a specified range.
%  RESCALE_RANGE(I,N1,N2) rescales the array I so that all elements fall in 
%  the range [N1,N2]. The output is double or single precision.
%
%   See also RESCALE.
%
%JC

% Convert input to double precision
if ~isa(I,'float')
    I=double(I);
end
Iclass=class(I);

% Make sure the data can be rescaled with the current machine precision
if nargin>1
    rangedata=cast(rangedata,Iclass);
    datarange=max(rangedata(:))-min(rangedata(:));
else
    datarange=max(I(:))-min(I(:));
end
if datarange > eps
    Iout = (I-min(rangedata(:)))/(datarange);
else
    Iout=I;
end

