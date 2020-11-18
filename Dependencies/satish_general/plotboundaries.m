function im=plotboundaries(labels,col,lw,im)    
%function im=plotboundaries(labels,col,lw,im)    

if ~exist('col','var') || isempty(col)
    col = 'r';
end

if ~exist('lw','var') || isempty(lw)
    lw = 2;
end

B=bwboundaries(labels);

if exist('im','var')
    immax = max(im(:));
    for k=1:length(B),
        boundary = B{k};
        for i=1:size(boundary,1)
            im(boundary(i,1),boundary(i,2),1)=immax;
        end
    end
else 
    for k=1:length(B),
        boundary = B{k};
        plot(boundary(:,2),boundary(:,1),'Color',col,'LineWidth',lw);
    end
end

end