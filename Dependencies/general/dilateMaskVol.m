function maskDil = dilateMaskVol(Imask,S,show)
% Imask is the input mask volume; S is the size of the radius element; show is a
% binary operator to show the dilated vs original masks
% - Rakesh 02/06/14

N = size(Imask,3);
maskDil = zeros(size(Imask));

if nargin < 3
    show = 0;
end

if nargin < 2
    S = 10;
end

Imask = double(Imask);
for i = 1:N
    temp = im2bw(Imask(:,:,i));
    maskDil(:,:,i) = imdilate(temp,strel('disk',S));
    if show
        figure(1); imshow(temp);figure(2);
        imshow(maskDil(:,:,i));
        pause;
    end
end