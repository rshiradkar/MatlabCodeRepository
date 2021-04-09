function [whiteneddata,mean_vec,mad_vec] = simplewhiten_rs(data,data1)
%function whiteneddata = simplewhiten(data)
%Whitening the data: Mean=0,MAD=1 on a per-feature basis
%Data should be N x D
%Accounts for cases where MAD=0 too
%Satish Viswanath, Mar 2010	

mean_vec = mean(data1,1);
temp = bsxfun(@minus,data,mean_vec);			%subtract means
mad_vec = mad(data1,1);
if sum(mad(data1,1))>=0								%checking for any MAD=0
	idx = find(mad(data1,1)==0);
	mad_vec(idx) = 1;                               %#ok<FNDSB>
end
whiteneddata = bsxfun(@rdivide,temp,mad_vec);		%divide by MAD


end