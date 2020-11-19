function rVol = rotateVol(V,th)

N = size(V,3);
[r,c] = size(imrotate(V(:,:,1),th));
rVol = zeros(r,c,N);

for i=1:N
    rVol(:,:,i) = imrotate(V(:,:,i),th);
end

