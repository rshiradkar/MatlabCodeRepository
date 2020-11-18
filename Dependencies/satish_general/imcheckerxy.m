function [Icheckerx,Icheckery] = imcheckerxy(I1,I2)
% IMCHECKER
%   Compare alignment of two images in a checkerboard pattern.
%
%   [ICHECKERX,ICHECKERY] = IMCHECKERXY(I1,I2,NCHECKS)
%
%IMCHECKER by JC
%IMCHECKERXY by SV

dims=size(I1);
if dims(1) ~= dims(2), error('Only square inputs'); end

nchecks = (dims(2))^2;
[X,Y]=meshgrid(linspace(1,nchecks^2,dims(2)),linspace(1,nchecks^2,dims(1)));

checkpatternx=logical(mod(ceil(X/nchecks),2));
Icheckerx=zeros(size(I1));
for i=1:size(I1,3),
    I2i=I2(:,:,i);
    Icheckeri=I1(:,:,i);
    Icheckeri(~checkpatternx)=I2i(~checkpatternx);
    Icheckerx(:,:,i)=Icheckeri;
end

checkpatterny=logical(mod(ceil(Y/nchecks),2));
Icheckery=zeros(size(I1));
for i=1:size(I1,3),
    I2i=I2(:,:,i);
    Icheckeri=I1(:,:,i);
    Icheckeri(~checkpatterny)=I2i(~checkpatterny);
    Icheckery(:,:,i)=Icheckeri;
end
