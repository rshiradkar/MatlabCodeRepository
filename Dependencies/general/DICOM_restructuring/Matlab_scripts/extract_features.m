
studies = {'case17_2','case16_2','case21_4'};
protnames = {'T1','skull_mask_T1','mask_T1','current_volume_T1','standardized_volume_T1','num_slice_T1'};

tic
for i=1:3
    FV_law=[];
    a1=5;
    a2=3;
    a3=6;
    eval(['num_slice=',studies{i},'.',protnames{a3},';'])
    for n=1:num_slice
        eval(['I=',studies{i},'.',protnames{a1},'(:,:,n);'])
        eval(['I_mask=',studies{i},'.',protnames{a2},'(:,:,n);'])
        law_features=extract_law(I,I_mask);
        FV_law=[FV_law;law_features];
    end
    eval([studies{i},'.law_T1 = FV_law;'])
    
end
toc
