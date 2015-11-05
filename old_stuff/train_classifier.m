% function classifier_struct = train_classifier(input_path, output_path, parameters)

classifier_struct = struct();

% if nargin == 0
    input_path = '~/workspace/nyu_cv_recognition_data/output_all/sigmas-1-2-6_subdiv-4.mat';
%     input_path = '~/workspace/nyu_cv_recognition_data/output/sigmas-1-6-13_subdiv-4.mat';
    L = 20;
% end

%%
fprintf('Starting classifier trainer\n')
load(input_path,'descriptors_struct');

%% Dimensionality reduction using PCA
data = cat(2,descriptors_struct.descriptors{:})';

data_mean = mean(data,1);
data_diff = data - ones(size(data,1),1) * data_mean;

C = (data_diff' * data_diff) / (size(data,1)-1);
[W,D] = eig(C);
W = W(:,end:-1:1);
W = W(:,1:L);
D = D(end:-1:1,end:-1:1);

variance = diag(D);

data_trans = data_diff*W;



% [W, data_trans, variance] = pca(data_diff,'Algorithm','eig');

%%
face_data = descriptors_struct.descriptors{1}';
face_data_diff = face_data - repmat(data_mean,size(face_data,1),1);
face_data_trans = face_data_diff * W;

nonface_data = descriptors_struct.descriptors{1}';
nonface_data_diff = nonface_data - repmat(data_mean,size(nonface_data,1),1);
nonface_data_trans = nonface_data_diff * W;


%%

classifier_struct.data_mean = data_mean;
classifier_struct.D = D(1:L,1:L);
classifier_struct.W = W;


%%
% D2 = (data_trans.^2)*variance(1:L);
% 
% figure(1)
% clf
% hold on
% 
% sample_index = 1;
% for class = 1:length(descriptors_struct.classes)
%     samples = size(descriptors_struct.descriptors{class},2);
%     data_class = D2(sample_index:sample_index+samples-1,:);
% 
%     histogram(data_class)
%     
% % %     plot3(data(1:step_size:end,1),data(1:step_size:end,2),data(1:step_size:end,3),'.','MarkerSize',4)
% %     plot(data_class(1:step_size:end,1),data_class(1:step_size:end,2),'.','MarkerSize',4)
% % %     plot3(data_class(1:step_size:end,1),data_class(1:step_size:end,2),data_class(1:step_size:end,3),'.','MarkerSize',4)
% %     sample_index = sample_index + samples;        
% end
% legend(descriptors_struct.classes)
% hold off


%%
figure(2)
clf
hold on
step_size = 10;
sample_index = 1;
plots = {};
for class = 1:length(descriptors_struct.classes)
    samples = size(descriptors_struct.descriptors{class},2);
    data_class = data_trans(sample_index:sample_index+samples-1,:);

%     plot3(data(1:step_size:end,1),data(1:step_size:end,2),data(1:step_size:end,3),'.','MarkerSize',4)
    plots{class} = plot(data_class(1:step_size:end,1),data_class(1:step_size:end,2),'.','MarkerSize',4)
%     plot3(data_class(1:step_size:end,1),data_class(1:step_size:end,2),data_class(1:step_size:end,3),'.','MarkerSize',4)
    sample_index = sample_index + samples;        
end
legend(descriptors_struct.classes)
xlabel('1st component')
ylabel('2nd component')


sample_index = 1;
for class = 1:length(descriptors_struct.classes)
    samples = size(descriptors_struct.descriptors{class},2);
    data_class = data_trans(sample_index:sample_index+samples-1,:);

    center = mean(data_class,1);
    p = plot(center(1),center(2),'.','MarkerSize',15)
    p.Color = plots{class}.Color;
%     plot3(center(1),center(2),center(3),'.','MarkerSize',15)
    sample_index = sample_index + samples;        
end


hold off



% end




