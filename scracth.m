clearvars
img = double(rgb2gray(imread('./images/I1.png')));

%%

numberOfAngles = 2;

parameters = struct();
parameters.angles = pi*(1:numberOfAngles)/numberOfAngles;
parameters.layerScale = [2, 2,2];
parameters.sigma = 2;
% parameters.layerScale = [1,2,3,5];

%

angles = parameters.angles;
layerScale = parameters.layerScale;
sigma = parameters.sigma;

% descriptor = zeros(length(angles),length(layerScale));

descriptor = zeros(length(angles).^(length(layerScale)+1)-1,1);


images = cell(0);
images{end+1} = img;
descriptorIndex = 1;
for layerIndex = 1:length(layerScale)
    scale = 1/layerScale(layerIndex);
    newImages = cell(length(images) * length(angles),1);
    fprintf('Size new images: %i\n',length(newImages))
    for imageIndex = 1:length(images)
        disp(imageIndex)
        image = images{imageIndex};
        for angleIndex = 1:length(angles)
            angle = angles(angleIndex);
            imgFilterd = morletFilter(image, angle, sigma);
            descriptor(descriptorIndex) = norm(mean(imgFilterd(:)));
            descriptorIndex = descriptorIndex + 1;
            imgResized = imresize(imgFilterd,scale);
            newImages{(imageIndex-1)*length(angles)+angleIndex} = imgResized;
        end        
    end
    images = newImages;
end
% descriptor = [descriptor;descriptor];

%%
figure(1)
drawDescriptor(descriptor,angles);

