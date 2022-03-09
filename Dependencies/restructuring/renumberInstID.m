function ddChange = renumberInstID(dd)

imgPos = [dd.ImagePositionPatient];
zLocation = imgPos(3,:);
[~,inds] = sort(zLocation,'descend');

ddChange = dd;

for i = 1:length(dd)
    ddChange(i).InstanceNumber = inds(i);
end