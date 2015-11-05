clearvars
face_path = 'face00010.pgm';
input_path = '~/workspace/nyu_cv_recognition_data/train/face/';

img = double(imread([input_path face_path]))/255;

% img = (1:16:255)/ 255;
% img = ones(16,1) * img;
% 
% img_sum = sum(img(:))
% 
% sigma = 3;
% angle = 0;
% kernel = morletWavelet(sigma,angle);  
% img_filter = conv2(img,kernel,'same');
% 
% % % img_filter = morletFilter(img, 0, 2);
% sum(img_filter(:))

% 

%%


kernel = morletWavelet(.5,0);
kernel = kernel(round(size(kernel,1)/2),:);
% 
% kernel = [ones(10,1); -ones(10,1)];
% kernel = kernel / sqrt(sum(kernel.^2));

% sum(kernel);
% sum(kernel.^2);


% img_filter = conv2(img,kernel,'same');



%
figure(1)
clf
hold on
plot(real(kernel))
plot(imag(kernel))
hold off
%%



figure(1)
subplot(2,1,1)
imshow(img)
subplot(2,1,2)
imshow(imag(img_filter))

