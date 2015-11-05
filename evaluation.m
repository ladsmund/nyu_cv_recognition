clearvars



classifier_parameters = get_default_classifier_parameters();
classifier_parameters.L = 40;
classifier_parameters.useNonefaceDist = 1;


% data_file_name = 'sigmas-1-3-6_subdiv-4.mat';
data_file_name = '*.mat';
input_folder = '~/workspace/nyu_cv_recognition_data/output_train/';
    output_dir = '~/workspace/nyu_cv_recognition_data/evaluations/';
data_files = dir([input_folder data_file_name]);
for i = 1:length(data_files)
    data_file_name = data_files(i).name;    
    input_path = [input_folder data_file_name]    
    
    cfMat =evaluate(input_path, classifier_parameters);
 
    sensitivity = cfMat(1,1) / sum(cfMat(:,1));
    specificity = cfMat(2,2) / sum(cfMat(:,2));

    fprintf('%s:\n\tsensitivity=%.4f\n\tspecificity=%.4f\n', output_name,sensitivity, specificity)

    output_name = sprintf('%s_L%i_nfd%i',data_file_name(1:end-4), classifier_parameters.L,classifier_parameters.useNonefaceDist)
    [~, ~]= mkdir(output_dir);
    output_path = [output_dir output_name '.mat'];
    

    save(output_path, 'cfMat');
    
end




