function ptileval = percentile(vector,ptile)
%function ptileval = percentile(vector,ptile)
% Calculating ptile value (0-1) in ordered data VECTOR
% Satish Viswanath, Mar 2010

if ptile>1
    ptile=ptile/100;
end

n = ptile*(length(vector)-1)+1;

k = floor(n);
d = round(mod(n*100,100));

ptileval = vector(k)+(d/100)*(vector(k+1)-vector(k));

end