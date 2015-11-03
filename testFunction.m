function testFunction(p)

%%
img = double(rgb2gray(imread('./images/I1.png')));
% Ensure the image is a power of two
img = imresize(img,2.^round(log2(size(img))));

if nargin == 0
    %%
    numberOfAngles = 2;
    p = struct();
    p.filter = struct();
    p.filter.angles = pi*(1:numberOfAngles)/numberOfAngles;
    p.filter.layerScale = [2, 2,2];
    p.filter.sigma = 2;
    p.extract = struct();
    p.extract.sub_division = 8;
    p.extract.sigma = 6;
    %%
end
%%
descriptor = generateDescriptor(img, p);

end

function descriptor = generateDescriptor(img, p)
descriptor = 0;

images = cell(0);
images{end+1} = img;
descriptorIndex = 1;
for layerIndex = 1:length(p.filter.layerScale)
    scale = 1/p.filter.layerScale(layerIndex);
    newImages = cell(length(images) * length(p.filter.angles),1);
    fprintf('Size new images: %i\n',length(newImages))
    for imageIndex = 1:length(images)
        disp(imageIndex)
        image = images{imageIndex};
        for angleIndex = 1:length(p.filter.angles)
            angle = p.filter.angles(angleIndex);
            
            imgFiltered = morletFilter(image, angle, p.filter.sigma);
            img_like = imgFiltered .* conj(imgFiltered);
            
            features = extractFeatures(img_like, p);
            
            descriptor(descriptorIndex) = norm(mean(imgFiltered(:)));
            descriptorIndex = descriptorIndex + 1;
            imgResized = imresize(imgFiltered,scale);
            newImages{(imageIndex-1)*length(p.filter.angles)+angleIndex} = imgResized;
        end        
    end
    images = newImages;
end

end

function features = extractFeatures(img_like, p)
    
    kernel = fspecial('gauss', [1, 1] * 2.5 * p.extract.sigma, p.extract.sigma);

    img_blured = conv2(img_like, kernel, 'same');
    
    step = size(img_blured) / p.extract.sub_division;
    
    features = img_blured(1:step(1):end, 1:step(2):end);
    
    
    
end
