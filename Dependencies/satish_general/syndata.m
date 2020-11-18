%The function [x,yn,y]=syndata(noise_type,A,B,C,n) is used to
%generate synthetic data with additive noise. The independent x
%is randomly generated in a 20-dimensional space from a uniform
%distribution on [A,B]. The dependent variable y is generated
%using the function y = sum_i C*x_i + r where C is a constant, i 
%runs from 1 to 10, and hence the last 10 independent variables 
%are noise. The variable r is the additive noise which can follow 
%the Gaussian, uniform, Laplacian, Gamma or Weibull distribution 
%depending on the choice of the 'noise_type'. 
%Author: Jinbo Bi (bij2@rpi.edu) 6/1/2003
%Inputs: noise_type -- the type of distributions that the additive
%         noise follows. If it is 'Gaussian', then Gaussian random
%         variable r will be generated. Similarly, other choices
%         include 'uniform', 'Laplacian', 'Gamma' and 'Weibull'.
%        A -- the left end of the interval for the uniform dist of x.
%        B -- the right end of the interval for the uniform dist of x.
%        C -- the constant coefficient used in the model to generate y.
%        n -- the number of the synthetic data examples.
%Outputs: x -- the n sample of the 20 independent variables.
%         yn -- the response y generated using the above function on x.
%         y -- the raw response y generated using y = sum_i C*x_i
%              without additive noise.

function [x,yn,y] = syndata(noise_type,A,B,C,n)
    
%generate independent variables x
R = unifrnd(A,B,n,20);
%perform normalization so that x has mean 0 and std 1
R = R - ones(n,1)*mean(R);
R = R/diag(std(R));
x = R;
%generate raw response y
w = [C*ones(10,1); zeros(10,1)];
y = x*w;
%plot(x,y);
%hold on
range = max(y)-min(y)

%generate normally-distributed noise
if strcmp(noise_type,'Gaussian')
    stdev = range/10;
    r = normrnd(0,stdev,n,1);
    yn = y+r;
    scatter(y,yn,'x');
    title('Gaussian noise data');
end

%generate uniformly-distributed noise
if strcmp(noise_type,'uniform')
    stdev = range/10;
    r = unifrnd(-stdev,stdev,n,1);
    r = r - mean(r);
    yn = y+r;
    scatter(y,yn,'x');
    title('Uniform noise data');
end

%generate Laplacianly-distributed noise
if strcmp(noise_type,'Laplacian')
    stdev = range/10;
    LB = stdev/sqrt(2);
    r = unifrnd(0,1,n,1);
    warning = r(r==0|r==1)
    idx = 1:n;
    ids = idx(r<=0.5);
    idb = setdiff(idx,ids);
    L = zeros(n,1);
    L(ids) = LB*log(2*r(ids));
    L(idb) = -LB*log(2-2*r(idb));
    yn = y+L;
%   hist(L);
    scatter(y,yn,'x');
    title('Laplacian noise data');
end

%generate gamma distributed noise
if strcmp(noise_type,'Gamma')
%    stdev = range/
%    A = 3.5; B = 5;
    A = 5; B = 5;
    r1 = gamrnd(A,B,n,1);
    r = unifrnd(0,1,n,1);
    r(r>=0.5) = 1;
    r(r<0.5) = -1;
    yn = y+ r.*r1./100;
    mean(r1./100)
    scatter(y,yn,'x');
    title('Gamma noise data');
end

%generate Weibull distributed noise
if strcmp(noise_type,'Weibull')
    stdev = range/10;
    ru = weibrnd(0.5,0.5,n,1);
    ru = ru /30;
    %WB = stdev/sqrt(2);
    r = unifrnd(0,1,n,1);
    r(r<0.5) = -1;
    r(r>=0.5) = 1;
    r = ru.*r;
    yn = y+r;
    scatter(y,yn,'x');
    title('Weibull noise data');
end

%print the axis labels
xlabel('Actual response');
ylabel('Disturbed response');
