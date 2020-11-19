function V = generateGridVolume(numRows,numCols,numSlices,gridSize)

I = zeros(numRows,numCols);

for i = gridSize:gridSize:numRows
    for j = gridSize:gridSize:numCols
        I(i,:) = 1;
        I(:,j) = 1;
    end
end

imshow(I);

V = repmat(I,1,1,numSlices);