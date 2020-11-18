function im = dispvecasimg(vec,inds,sz)
% function im = dispvecasimg(vec,inds,sz)
% Display  image from input VEC (NxD), given INDS (Nx1) of pixel locations of image of size (2D vector) SZ
% SV, Mar 2010

if isempty(vec)
    im = [];
    return
end

im=zeros(sz);
im = reshape(im,size(im,1)*size(im,2),size(im,3));
im(inds,:) = double(vec);
im = reshape(im,sz);

end