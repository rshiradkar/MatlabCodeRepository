%% extract features


load('data_Set2.mat');
lesionLabels = xlsread('data_Set2_LesionLabels.xlsx');
lesionLabels = lesionLabels(:,1:2);

rL = 100; rH = 300; cL = 100; cH = 300;
Feats_t1 = []; Feats_t2 = []; Labels = []; Patient = [];

%%

for i = 1 : length(data)
    if ~isempty(data{i})
        study = data{i};
        for j = 1:length(study)
            I_t1 = study(j).t1;
            I_t2 = study(j).t2;
            I_t2 = 0.8156*I_t2+0.7793; %apply linear correction
            mask = study(j).mask;
            labelType = study(j).desc;
            
            if(~isempty(mask))
                % feats_t1 = computeTextureFeatures(I_t1(rL:rH,cL:cH), mask(rL:rH,cL:cH));
                feats_t1 = computeCollageFeatures(I_t1(rL:rH,cL:cH), mask(rL:rH,cL:cH));
                % feats_t1 = reshape(I_t1(mask==1),[],1);
                % feats_t1 = mean(feats_t1,1);
                % feats_t2 = computeTextureFeatures(I_t2(rL:rH,cL:cH), mask(rL:rH,cL:cH));
                feats_t2 = computeCollageFeatures(I_t2(rL:rH,cL:cH), mask(rL:rH,cL:cH));
                % feats_t2 = reshape(I_t2(mask==1),[],1);
                % feats_t2 = mean(feats_t2,1);
                % [feats_t1,feats_t2] = computeTextureFeaturesROI(I_t1(rL:rH,cL:cH),I_t2(rL:rH,cL:cH),mask(rL:rH,cL:cH));
                % feats_t1 = study(j).meanT1;
                % feats_t2 = study(j).meanT2;
                
                switch labelType
                    case 'cancer'
                        label = 1;
                    case 'benign'
                        label = 2;
                    case 'npz'
                        label = 3;
                end
                
                Labels= [Labels ; repmat(label,size(feats_t1,1),1)];
                Feats_t1 = [Feats_t1 ; feats_t1];
                Feats_t2 = [Feats_t2 ; feats_t2];
                Patient = [Patient ; (i+24)*ones(size(feats_t1,1),1)];
                %                 Patient = [Patient;i+25];
            end
        end
    end
end