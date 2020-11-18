function im = dispcl(labs,inds,sz,d,name)
% function IM = dispcl(VAR,INDS,SZ,D)
% Display  RGB image of classification (clusters)  LABS (Nx1), given INDS (Nx1) of pixel locations of image of size (2D vector) SZ
% if D is set, IM is displayed.
% Note: Ideally MAX(LABS)=3 (image will display as RGB)
%SV, Feb 2009

if isempty(labs)
    im = [];
    return
end

if nargin<5
    name = '';
end

for i=1:max(labs)
    l=zeros(sz);
    l(inds) = double(labs==i)*i;
    if i==1
        res = l;
    else
        res = cat(3,res,l);
    end
end

if max(labs)==2
    res = cat(3,res,zeros(sz));
end
    

if d && size(res,3)<=3
	imdisp(rescale(res));title(name);
end
    

im=zeros(sz);
for i=1:max(labs)
    im = im+res(:,:,i);
end

if d && size(res,3)>3
    dispimg(im);title(name);
end

end