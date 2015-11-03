
input_path = '~/workspace/nyu_cv_recognition_data/train/';
output_path = '~/workspace/nyu_cv_recognition_data/output/';
[~,~] = mkdir(output_path);

for sub_devision = [8, 4, 2, 1]
    for sigma = [1,2,4,8]
        name = sprintf('sd%i_ang4_lSc2_lSigma%i',sub_devision,sigma);
        disp('***********************')
        disp(name)
        disp('***********************')
        parameters = get_default_parameters(4,8);
        descriptors_struct = batch_descriptors(input_path, parameters);
        save([output_path name], 'descriptors_struct');
    end
end

