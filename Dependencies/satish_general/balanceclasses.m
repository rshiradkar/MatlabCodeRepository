function use_inds = balanceclasses(labels)
% [USE_INDS] = balanceclasses(LABELS)
% Balancing class distributions to 50-50 for the binary class case
%
% LABELS should be a vector 1xn 
% USE_INDS are the indices of points to be kept in LABELS to ensure class
% balance
% Note that USE_INDS is based on random sampling
% Satish Viswanath, Nov 2011
%
% See also: RANDPERM

% Checks
if length(unique(labels)) ~= 2
    error('Bad number of classes in input, this function is for binary (2) class case.');
end

if size(labels,1) ~= 1 && size(labels,2) ~= 1
    error('LABELS is supposed to be a vector, incorrectly input.');
end
    
class1inds = find(labels==min(labels));class2inds = find(labels==max(labels)); 
numclass1 = length(class1inds);numclass2 = length(class2inds);

if numclass1 > numclass2
    class1list = randperm(numclass1);class1list = class1list(1:numclass2);    
    class2list = 1:numclass2;
elseif numclass1 < numclass2
    class2list = randperm(numclass2);class2list = class2list(1:numclass1);    
    class1list = 1:numclass1;
else %numclass1 == numclass2
    class1list = 1:numclass1;
    class2list = 1:numclass2;
end

use_inds = sort(cat(2,class1inds(class1list),class2inds(class2list)));

end