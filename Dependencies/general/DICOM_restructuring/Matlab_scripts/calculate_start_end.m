function [slice_start, slice_end, num_slice]=calculate_start_end(mask_rot)
s=size(mask_rot);
ind=[];
num_slice=s(3);
for i = 1:num_slice
    tot=sum(sum(mask_rot(:,:,i)));
    if tot>0
        ind=[ind i];
    end
end
slice_start=min(ind);
slice_end=max(ind);
num_slice=length(ind);%number of slices that have masks