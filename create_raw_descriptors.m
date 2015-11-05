
input_path = '~/workspace/nyu_cv_recognition_data/train/';
output_path = '~/workspace/nyu_cv_recognition_data/output/';
[~,~] = mkdir(output_path);

sigma_parameteres = {[1;6;13],[1;2;6]};

for sub_division = [1,2,4]
    for sigma_indx = 1:length(sigma_parameteres)
        sigmas = sigma_parameteres{sigma_indx};
        
        str_sigmas = ['sigmas' sprintf('-%.0f',sigmas)];
        str_sub_div = ['subdiv' sprintf('-%.0f',sub_division)];
        name = sprintf('%s_%s',str_sigmas, str_sub_div);
        disp('***********************')
        disp(name)
        disp('***********************')
        parameters = get_default_parameters(4,sub_division);
        parameters.filter.sigmas = sigmas';
        descriptors_struct = batch_descriptors(input_path, parameters);
        save([output_path name], 'descriptors_struct');
    end
end

%%
