function descriptor = generateDescriptor(img, p)

images = cell(0);
images{end+1} = img;

features = extractFeatures(img, p);
descriptor = features(:);
for layerIndex = 1:p.filter.layers    
    newImages = cell(length(images),length(p.filter.angles),length(p.filter.sigmas));
%     fprintf('Number of images in layer: %i\n',numel(newImages))
    for imageIndex = 1:length(images)
        image = images{imageIndex};
        for sigmaIndex = 1:length(p.filter.sigmas)
            sigma = p.filter.sigmas(sigmaIndex);
            for angleIndex = 1:length(p.filter.angles)
                angle = p.filter.angles(angleIndex);

                imgFiltered = morletFilter(image, angle, sigma);
                img_like = sqrt(imgFiltered .* conj(imgFiltered));

                features = extractFeatures(img_like, p);
                descriptor = [descriptor; features(:)];

                newImages{imageIndex,angleIndex,sigmaIndex} = img_like;
            end
        end
    end
    images = newImages(:);
end

end

function features = extractFeatures(img_like, p)    
    kernel = fspecial('gauss', [1, 1] * 2.5 * p.extract.sigma, p.extract.sigma);
    img_blured = conv2(img_like, kernel, 'same');        
    features = imresize(img_blured, p.extract.sub_division);    
end