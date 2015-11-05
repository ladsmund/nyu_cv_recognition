clearvars


classifier_parameters = get_default_classifier_parameters();
classifier_parameters.L = 40;
classifier_parameters.useNonefaceDist = 1;
classifier_parameters.ShowSVMPlot = 1;

input_path = '~/workspace/nyu_cv_recognition_data/output_train/sigmas-1-3-7_subdiv-5.mat';
% input_path = '~/workspace/nyu_cv_recognition_data/output_train/sigmas-1-3-6_subdiv-2.mat';

load(input_path,'descriptors_struct');

data_face = descriptors_struct.descriptors{1}';
data_nonface = descriptors_struct.descriptors{2}';

labels_face = ones(size(data_face,1),1);
labels_nonface = 2*ones(size(data_nonface,1),1);
labels = [labels_face(:); labels_nonface(:)];

classifier = create_classifier([data_face;data_nonface], labels, classifier_parameters);

% 
% %% Transform Descriptor Space
% 
% mean_face = mean(data_face,1);
% mean_nonface = mean(data_nonface,1);
% 
% trans_face = @(D) D - repmat(mean_face,size(D,1),1);
% trans_nonface = @(D) D - repmat(mean_nonface,size(D,1),1);
% 
% [W_face, eig_face, var_face] = pca(trans_face(data_face));
% [W_nonface, eig_nonface, var_nonface] = pca(trans_nonface(data_nonface));
% 
% % Reduce dimensions
% W_face = W_face(:,1:L);
% W_nonface = W_nonface(:,1:L);
% var_face = var_face(1:L);
% var_nonface = var_nonface(1:L);
% 
% face_dist = @(D) (trans_face(D) * W_face).^2 * var_face.^-1; 
% nonface_dist = @(D) (trans_nonface(D) * W_nonface).^2 * var_nonface.^-1; 
% get_descriptor = @(D) [face_dist(D), nonface_dist(D)];
% % get_descriptor = @(D) [face_dist(D)];
% 
% %% Train Classifier
% faces = get_descriptor(data_face);
% nonfaces = get_descriptor(data_nonface);
% 
% % Find class names
% class_face = ones(size(faces,1),1);
% class_nonface = 2*ones(size(nonfaces,1),1);
% classes = [class_face(:); class_nonface(:)];
% 
% % Train SVM
% svmStruct = svmtrain([faces;nonfaces], classes);
% % svmStruct = svmtrain([faces;nonfaces], classes,'ShowPlot',true);
% classifier = @(D) svmclassify(svmStruct, get_descriptor(D));

%%



tp = mean(classifier(data_face) == 1)
fn = mean(classifier(data_face) ~= 1)
tn = mean(classifier(data_nonface) == 2)
fp = mean(classifier(data_nonface) ~= 2)

