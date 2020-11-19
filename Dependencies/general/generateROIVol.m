function V = generateROIVol(inV)

V =zeros(size(inV));

for i = 1:size(inV,3)
    imshow(inV(:,:,i));
    h = imfreehand;
    bw = createMask(h);
    V(:,:,i) = bw;
end

close all;

% for i = 1:size(MR,3)
%     imshow(MR(:,:,i)*50);
%     h = imfreehand;
%     bw = createMask(h);
%     MR_mask(:,:,i) = bw;
% end
