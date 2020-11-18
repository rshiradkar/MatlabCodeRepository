function [acc_wm,acc_gm] = findgmwm(labs,wm,gm)
%function [stats_wm,stats_gm] = findgmwm(labs,wm,gm)

if isempty(labs)
    stats_wm=zeros(1,4);stats_gm=zeros(1,4);
    return;
end

m = logical(gm+wm);
[stats_wm] = classfnevln(labs==1,wm,m,0.5,0);
[stats_gm] = classfnevln(labs==1,gm,m,0.5,0);
if (stats_wm(4)) > (stats_gm(4))
	%stats_wm = stats_wm;
	stats_gm = classfnevln(labs==2,gm,m,0.5,0);
else
	%stats_gm = stats_gm;
	stats_wm = classfnevln(labs==2,wm,m,0.5,0);
end

acc_wm = stats_wm(4);
acc_gm = stats_gm(4);

end