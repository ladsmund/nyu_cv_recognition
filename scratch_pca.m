
data = randn(2,1000);
data(1,:) = data(1,:)*3;

rot_mat = ([1 -1; 1 1] / sqrt(2));

data = rot_mat * data;

data = abs(data);
data = ([-1 -1; -1 1] / sqrt(2)) * data;


% data = [10,9; .1,5]*data.^2;
% data = data + 5*rand(2,200);
%%

data_mean = mean(data,2);
data_diff = data - mean(data,2)*ones(1,size(data,2));
C = (data_diff * data_diff') / (size(data,2)-1);
%
[Q,lambda] = eig(C);

Q = Q(end:-1:1,end:-1:1);
lambda = lambda(end:-1:1,end:-1:1);

[pc,score] = pca(data');

Q
rot_mat
pc
%
%%

data_trans1 = Q(1,:)*data_diff;
data_trans2 = Q(2,:)*data_diff;
data_trans = Q*data_diff

%


figure(1)
subplot(2,1,1)
plot(data(1,:),data(2,:),'.','MarkerSize',2)
axis equal
subplot(2,1,2)
plot(data_trans(1,:),data_trans(2,:),'.k','MarkerSize',2)
hold on
plot(data_trans1,data_trans1*0,'.r','MarkerSize',10)
plot(data_trans2*0,data_trans2,'.b','MarkerSize',10)
hold off
axis equal


