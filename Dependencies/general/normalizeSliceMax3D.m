function output = normalizeSliceMax3D(input,mask)
% normalizes each of the 2D slices of the 3D matrix 'input' by dividing
% each of the 2D slice by its respective max value

N = size(input,3);
output = zeros(size(input));

for i = 1:N
    if nargin < 2
        temp = input(:,:,i);
    else
        temp = input(:,:,i).*mask(:,:,i);
    end
    output(:,:,i) = temp/max(temp(:));
end
