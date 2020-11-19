function overlayProbMap(V,maskV,probV,string,transp,maskC)
% V - grayscale image/volume
% maskV - volume where to overlay prob (indicate by 1)
% probV - probability you want to overlay
% trasp - transparency of overlay (default = 1)
% maskC - ground truth mask
% - Rakesh 02/03/15, edit 1 - 03/10/15

if nargin < 5
    transp = 1;
end
cmap = colormap('jet');
numColors = size(cmap,1);

warning off;

existMask = reshape(sum(sum(maskV,1),2),[],1);
for i = 1:size(V,3)
    
    if existMask(i)>0
        I = V(:,:,i);
        mask = maskV(:,:,i);
        prob = probV(:,:,i);
        indImg = round(prob*numColors);
        rgbImg = ind2rgb(indImg,cmap);
        I = double(I);
        I = I/max(I(:));
        mask = double(mask);
        if nargin > 4
            subplot(1,2,1);
            imshow(I);
            hold on;
            h = imshow(rgbImg);
            set(h,'AlphaData',transp*mask)
            subplot(1,2,2);
            imshow(I);
            hold on;
            edgeC = edge(maskC(:,:,i),'canny');
            h1 = imshow(edgeC);
            set(h1,'AlphaData',transp*edgeC);
            
        else
            imshow(I);
            hold on;
            h = imshow(rgbImg);
            set(h,'AlphaData',transp*mask)
        end
%         x = input('do you want to print? 1=YES/0=NO ');
%         if x==1
            print('-r300',[string '_' num2str(i) '.png'],'-dpng');
%         end
    end
end
