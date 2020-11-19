function output = repeatFuncOver3D(handle,input)

% input - 3D input matrix 
% handle - function to be applied to each slice of the input

N = size(input,3);
output = zeros(size(input));

for i = 1:N
    output(:,:,i) = handle(input(:,:,i));
end


    