function descriptor = generateDescriptor(img, p)

images = cell(0);
images{end+1} = img;

descriptor = [];
for layerIndex = 1:length(p.filter.layerScale)
    scale = 1/p.filter.layerScale(layerIndex);
    newImages = cell(length(images) * length(p.filter.angles),1);
%     fprintf('Number of images in layer: %i\n',length(newImages))
    for imageIndex = 1:length(images)
        image = images{imageIndex};
        for angleIndex = 1:length(p.filter.angles)
            angle = p.filter.angles(angleIndex);
            
            imgFiltered = morletFilter(image, angle, p.filter.sigma);
            img_like = imgFiltered .* conj(imgFiltered);
            
            features = extractFeatures(img_like, p);
            
            descriptor = [descriptor; features(:)];
            
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
    features = imresize(img_blured, p.extract.sub_division);    
end