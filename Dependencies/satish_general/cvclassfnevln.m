function [auc,acc] = cvclassfnevln(classfn,testing_labels)
% function [AUC,acc] = cvclassfnevln(classfn,testing_labels)

    if ~isa(classfn,'cell') || ~isa(testing_labels,'cell')
        error('cvclassfnevln:badData','Wrong data types for inputs');
    end

    if length(unique(classfn{1,1})) > 52
        x_vals = (0:0.02:1);
    else
        x_vals = 'all';
    end

    parfor iter=1:size(classfn,1)
        [X,Y,~,auc(iter,:)] = perfcurve(testing_labels(iter,:),classfn(iter,:),1,'xVals',x_vals);
        [~,accuracy] = perfcurve(testing_labels(iter,:),classfn(iter,:),1,'YCrit','accu');  
        fpr = X(:,1); tpr = Y(:,1);

        disttocorner = zeros(length(fpr),1);
        for k=1:length(fpr)
            disttocorner(k) = sqrt((fpr(k)-0)^2+(tpr(k)-1)^2);            
        end    
        [~,oc] = min(disttocorner);
        acc(iter,1) = accuracy(oc);    
    end

end