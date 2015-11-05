function cfMat = evaluate(data_path, classifier_parameters)

load(data_path,'descriptors_struct');

data_face = descriptors_struct.descriptors{1}';
data_nonface = descriptors_struct.descriptors{2}';
data = [data_face;data_nonface];

labels_face = ones(size(data_face,1),1);
labels_nonface = 2*ones(size(data_nonface,1),1);
labels = [labels_face(:); labels_nonface(:)];

f = @(xtr,ytr,xte,yte)confusionmat(yte,classify(xte,xtr,ytr,classifier_parameters));

cfMat = crossval(f,data,labels);
cfMat = reshape(sum(cfMat),2,2)';

end