function drawDescriptor(descriptor, radius)

if nargin < 2
    radius = 50;
end

% Normalize
descriptor = descriptor / max(descriptor(:));

numberOfAngles = size(descriptor,1);
numberOfLayers = size(descriptor,2);

angles = 2*pi*(1:numberOfAngles)/numberOfAngles;
layers = radius * (1:numberOfLayers) / numberOfLayers;

%%
img = zeros(2*radius+1);

[xs, ys] = meshgrid(1:size(img,1),1:size(img,1));
xs = xs(:)-radius;
ys = ys(:)-radius;

[phi, r] = cart2pol(xs,ys);
phi = phi + pi;

layerIndex = 1;
lastLayer = 0;
for layer = layers
    angleIndex = 1;
    lastAngle = 0;
    for angle = angles
%         fprintf('Angle: %.2fpi-%.2fpi, layer: %i-%i, value %0.2f\n',lastAngle/pi, angle/pi, lastLayer, layer, descriptor(angleIndex,layerIndex))
        
        radiusConstrain = (r > lastLayer) & (r <= layer);
        angleConstrain = (phi > lastAngle) & (phi <= angle);
        
        
        img(radiusConstrain & angleConstrain) = descriptor(angleIndex,layerIndex);
        
        angleIndex = angleIndex + 1;
        lastAngle = angle;
    end    
    layerIndex = layerIndex + 1;
    lastLayer = layer;
end
imshow(img);

end