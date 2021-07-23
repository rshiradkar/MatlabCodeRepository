destDir = 'G:\.shortcut-targets-by-id\1lRjm8H415GVMV9hWhB-yTApVJlWcKIsZ\UH_45PAT_PPF';
cd(destDir)


for i=2:length(patients)
T2 = [patients(i).name(13:end) '_T2.mha'];
ADC = [patients(i).name(13:end) '_ADC.mha'];

system(['C:\Elastix\elastix -f ' destDir filesep T2 ' -m ' destDir filesep ADC ' -p C:\Elastix\rigid.txt -out C:\Elastix\params']);
system(['C:\Elastix\transformix -in ' destDir filesep ADC ' -tp C:\Elastix\params\TransformParameters.0.txt -out ' destDir]);

movefile([destDir filesep 'result.mha'], [destDir filesep patients(i).name(13:end) '_ADC_reg.mha']);
end
