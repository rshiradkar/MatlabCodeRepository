function im = disp2dvecasvol(vec,inds,sz)
% function im = disp2dvecasvol(vec,inds,sz)
% Display  image from input VEC (NxD), given INDS (Nx1) of pixel locations of vole of size (3D vector) SZ
% SV, Mar 2010

if isempty(vec)
    im = [];
    return
end

im=zeros(sz);
im = reshape(im,[size(im,1)*size(im,2)*size(im,3),1]);
im(inds) = double(vec);
im = reshape(im,sz);

end