function classifier = create_classifier(data, labels, classifier_parameters)

L = classifier_parameters.L; 
L = min(L, size(data,2));


data_face = data(labels == 1,:);
data_nonface = data(labels == 2,:);

%% Transform Descriptor Space
mean_face = mean(data_face,1);
mean_nonface = mean(data_nonface,1);

trans_face = @(D) D - repmat(mean_face,size(D,1),1);
trans_nonface = @(D) D - repmat(mean_nonface,size(D,1),1);

[W_face, ~, var_face] = pca(trans_face(data_face));
[W_nonface, ~, var_nonface] = pca(trans_nonface(data_nonface));

% Reduce dimensions
W_face = W_face(:,1:L);
W_nonface = W_nonface(:,1:L);
var_face = var_face(1:L);
var_nonface = var_nonface(1:L);

face_dist = @(D) (trans_face(D) * W_face).^2 * var_face.^-1; 
nonface_dist = @(D) (trans_nonface(D) * W_nonface).^2 * var_nonface.^-1; 

if classifier_parameters.useNonefaceDist
    get_descriptor = @(D) [face_dist(D), nonface_dist(D)];
else
    get_descriptor = @(D) [face_dist(D)];
end

%% Train Classifier
faces = get_descriptor(data_face);
nonfaces = get_descriptor(data_nonface);

% Train SVM
% svmStruct = svmtrain([faces;nonfaces], labels);
svmStruct = svmtrain([faces;nonfaces], labels,'ShowPlot',classifier_parameters.ShowSVMPlot);

classifier = @(D) svmclassify(svmStruct, get_descriptor(D));
   
end