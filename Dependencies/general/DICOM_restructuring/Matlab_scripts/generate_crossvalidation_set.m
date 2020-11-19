% necrosis metastasis (8)
% studies = {'case3_2','case4_3','case7_2','case22_3','case30_2','case40_3','case69_1','case76_2'};

% recurrent metastasis (12)
% studies = {'case17_2','case16_2','case21_4','case31_3','case32_2','case37_1','case50_1','case55_1','case59_1','case65_1','case68_1','case75_2'};
 
% necrosis primary (10)
%studies = {'case2_1','case1_3','case9','case12_2','case23','case33','case35_1','case43_1','case39_2','case44'};
  
% recurrent primary (12)
studies = {'case2_1','case1_3','case9','case12_2','case23','case33','case35_1','case43_1','case39_2','case44','case14_2','case15_2','case18_1','case19_2','case20','case24_2','case25_2','case53_1','case26_2','case61_1','case67_1','case70_1'};
Slice_array=[];
Total_slices=128;

groups = [ones(66,1);zeros(62,1)];

for i = 1:22
    eval(['tem=',studies{i},'.num_segment_T1;']);
    Slice_array=[Slice_array tem];
end
test_label_cumulative=[];
Predicted_label_cumulative=[];

for patient_no = 2:22
    training_set=[];
    training_set_label=[];
    test_set=[];
    test_set_label;
    
    eval(['tem_current=',studies{patient_no},'.num_segment_T1;']);
    if (patient_no>1)
    %eval(['tem_prev=',studies{patient_no},'.num_slice_T1;']);
    Num_prev_slices=sum(Slice_array(1:patient_no-1));
    test_set=Vol_Slice(Num_prev_slices+1:Num_prev_slices+tem_current,:);
    test_set_label=groups(Num_prev_slices+1:Num_prev_slices+tem_current,:);
    training_set=[Vol_Slice(1:Num_prev_slices,:);Vol_Slice(Num_prev_slices+tem_current+1:Total_slices,:)];
    training_set_label=[groups(1:Num_prev_slices,:);groups(Num_prev_slices+tem_current+1:Total_slices,:)];
    else
    test_set=Vol_Slice(1:tem_current,:);
    training_set=[Vol_Slice(tem_current+1:Total_slices,:)];
    end
    svmStruct = svmtrain(training_set,training_set_label);
    Group = svmclassify(svmStruct,test_set);
    
    test_label_cumulative=[test_label_cumulative;test_set_label];
    Predicted_label_cumulative=[Predicted_label_cumulative;Group];
end
C = confusionmat(test_label_cumulative,Predicted_label_cumulative);

        
    
    