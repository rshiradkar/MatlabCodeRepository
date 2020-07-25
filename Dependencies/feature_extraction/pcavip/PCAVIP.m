function VIPscores = PCAVIP(X,Y,h)
% PCA-transform data and calculate VIP scores

%%% Input:
%%% X (n x p) is a matrix with p features and n observations
%%% Y (n x 1) is a vector of outcome variables (categorical)
%%% h (scalar) is the intrinsic dimensionality

%%% Output:
%%% VIPscores (p x 1) is a vector of VIP scores for the p features

[loadings,scores] = princomp(X); % perform PCA
b = (scores'*scores)^(-1)*(scores'*Y); % get regression coefficients

b = b(1:h); % drop all but h dimensions
loadings = loadings(:,1:h);
scores = scores(:,1:h);

S = zeros(h,1); scor = sum(scores.^2);
for i = 1:h, S(i) = scor(i)*(b(i)^2); end

w = sum(loadings.^2);
[p,temp] = size(loadings);

VIPscores = zeros(p,1);
for j = 1:p
    temp = loadings(j,:).^2;
    num = zeros(h,1);
    for i = 1:h, num(i) = S(i)*temp(i)/w(i); end
    VIPscores(j) = sqrt(p*sum(num)/sum(S)); 
end