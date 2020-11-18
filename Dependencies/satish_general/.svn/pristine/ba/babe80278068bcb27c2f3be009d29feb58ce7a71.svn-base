
k = fspecial('average',[1 50]);
for i=1:37

[canccount,cancints] = count(alldata(1,i).img(gt{i}==1));
[normcount,normints] = count(alldata(1,i).img((whole{i}-gt{i})==1));
allcounts = count(alldata(1,i).img(whole{i}==1));
canccount = canccount./sum(canccount);
normcount = normcount./sum(normcount);
subplot(1,2,1);plot(cancints,conv(canccount,k,'same'),'r');hold on;
subplot(1,2,1);plot(normints,conv(normcount,k,'same'),'b');hold off;

[canccount,cancints] = count(alldata(2,i).img(gt{i}==1));
[normcount,normints] = count(alldata(2,i).img((whole{i}-gt{i})==1));
allcounts = count(alldata(2,i).img(whole{i}==1));
canccount = canccount./sum(canccount);
normcount = normcount./sum(normcount);
subplot(1,2,2);plot(cancints,conv(canccount,k,'same'),'r');hold on;
subplot(1,2,2);plot(normints,conv(normcount,k,'same'),'b');hold off;

pause;

end