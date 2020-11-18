function [whiteneddata,B,scales] = whiten(data)
%function whiteneddata = whiten(data)
%Whitening the data via PCA
%Data should be D x N
%First makes mean=0
%Then PCA based rescaling/prung (from jadeR.m)
%Note that this code will prune the number of output dimensions. to the #PCswhich retain 99.99% of
%the variance from the original data. This has been done so that no imaginary components are
%calculated. Additionally, retaining ALL components will probably
%lead to a lot of noise being introduced, as components which contribute
%the remainder 0.01% (over the 99.99% retained) are probably crap.
%Satish Viswanath, Nov 2010	
%
%	See also: jadeR

verbose=1;
[nf,ns]	= size(data);

% Mean=0, MAD=1
%if verbose, fprintf('whiten -> Removing the mean value, normalizing MAD value\n'); end 	
if verbose, fprintf('whiten -> Removing the mean value\n'); end 	
data = permute(data,[2 1]);
data = bsxfun(@minus,data,mean(data,1));	
% temp = bsxfun(@minus,data,mean(data,1));	
% mad_vec = mad(data,1);
% if sum(mad(data,1))>0								%checking for any MAD=0
% 	idx = find(mad(data,1)==0);
% 	mad_vec(idx) = 1;
% end
% data = bsxfun(@rdivide,temp,mad_vec);		%divide by MAD
data = permute(data,[2 1]);

% whitening & projection onto signal subspace
if verbose, fprintf('whiten -> Whitening the data\n'); end

% if nargin<3,
[U,D]     = eig((data*data')/ns);   %% An eigen basis for the sample covariance matrix
[Ds,k]    = sort(diag(D));          %% Sort by increasing variances
varscaptured = cumsum(flipud(Ds))/sum(Ds);
if nf > 1
    fprintf('Automatically pruning output data to retain 99.99%% of variance.\n');
    PCs = nf - find(varscaptured<0.9999)+1;
else
    PCs = 1;
end

% PCA 
B         = U(:,k(PCs))'    ;       %% At this stage, B does the PCA on m components

% Scaling 
scales    = sqrt(Ds(PCs)) ;         %% The scales of the principal components .
B         = diag(1./scales)*B  ;    %% Now, B does PCA followed by a rescaling = sphering

% Sphering 
whiteneddata         = B*data;      %% We have done the easy part: B is a whitening matrix and X is white.
B = B(:,k(PCs));


end