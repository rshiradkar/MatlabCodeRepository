function [pre_clipped,post_clipped] = topclip(pre,post,numstd)
% function [pre_clipped,post_clipped] = topclip(pre,post,numstd)

if ~exist('numstd','var')||isempty(numstd)
    numstd=5;
end

topclipval=median(pre(pre~=0))+numstd*std(pre(pre~=0));
pre_clipped=pre;

numvals_top = length(find(pre_clipped>topclipval));
pre_clipped(pre_clipped>topclipval)=round(linspace(topclipval,topclipval-std(pre(pre~=0)),numvals_top));
if exist('post','var') && ~isempty(post)
    % do NOT independently rescale data!
    topclipval=topclipval*max(post(post~=0))/max(pre(pre~=0));
    post_clipped=post;
    %post_clipped(post_clipped>topclipval)=round(topclipval);
    numvals_top = length(find(post_clipped>topclipval));
    post_clipped(post_clipped>topclipval)=round(linspace(topclipval-std(pre(pre~=0)),topclipval,numvals_top));
end

end