function p = randpermnew(n,s)
% function P = randpermnew(N,S)
% Modified to use an input S for initializing RAND with. S should therefore
% be a random number (maybe generated with SAMPLERAND?)
% Based on RANDPERM Random permutation.
%   RANDPERM(n) is a random permutation of the integers from 1 to n.
%   For example, RANDPERM(6) might be [2 4 5 6 1 3].
%   
%   Note that RANDPERM calls RAND and therefore changes RAND's state.
%
%   See also PERMUTE, SAMPLERAND.
%

%   Copyright 1984-2004 The MathWorks, Inc.
%   $Revision: 5.10.4.1 $  $Date: 2004/03/02 21:48:27 $
%   Modified by Satish Viswanath, 2008

if nargin == 2
    rand('twister',s);
end
[ignore,p] = sort(rand(1,n));
