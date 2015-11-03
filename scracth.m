
input_path = '~/workspace/nyu_cv_recognition_data/train/';
output_path = '';
parameters = get_default_parameters;


descriptors_struct = batch_descriptors(input_path, parameters);

save('descriptors_struct', 'descriptors_struct');