function im = dispem(var,inds,sz)
% function IM = dispem(VAR,INDS,SZ)
% Display  RGB image of embedding VAR (Nx3), given INDS (Nx1) of pixel
% locations of image of size (2D vector) SZ
%SV, Feb 2009

r=zeros(sz);g=r;b=r;

if size(var,2)==2
    var(:,3)=zeros(size(var,1),1);
end

r(inds) = var(:,1);
g(inds) = var(:,2);
b(inds) = var(:,3);
im = cat(3,r,g,b);


end
