function [n,x] = histpdf(samples,bins)

[n,x] = hist(samples,bins);
n = n/sum(n)/(x(2)-x(1));

if nargout == 0
    figure; hold on;
    bar(x,n);
end
