function [filtered, padlength] = morletFilter(img, angle, sigma)
    
    [filtered, padlength] = morletFilterMads(img, angle, sigma);
%     filtered = morletFilterMarcelo(img, angle - pi/2, sigma);

end

function [filtered, padlength] = morletFilterMarcelo(img, angle, sigma)
    freq = 1/sigma;
    padlength = 0;
    [mr,mi] = cmorlet(sigma,freq,angle,0);
    filtered = padimage(conv2(img,mr+1i*mi,'same'),padlength,'complex');
end

function [filtered, padlength] = morletFilterMads(img, angle, sigma)
% Create kernel
kernel = morletWavelet(sigma,angle);  

% [mr,mi] = cmorlet(sigma,1/sigma,-angle+pi/2,0);
% kernel = mr + mi*1i;

xPad = size(kernel,1);
yPad = size(kernel,2);

padlength = max(xPad,yPad);

% img = fadeinandout(img,padlength);

% Pad
imgPad = padarray(img,[xPad yPad],'replicate');
imgPadFilterd = conv2(imgPad, kernel, 'same');
filtered = imgPadFilterd(xPad+1:end-xPad, yPad+1:end-yPad);

% Fade-in/out
% filtered = conv2(fadeinandout(img,max(xPad,yPad)), kernel, 'same');


% Use only central square of image
% [v, minIndx] = min(size(filtered));
% d = abs(diff(size(filtered)));
% if minIndx == 1
%     filtered(:,1:floor(d/2)) = 0;
%     filtered(:,(end-ceil(d/2)):end) = 0;
% else
%     filtered(1:floor(d/2),:) = 0;
%     filtered((end-floor(d/2)):end,:) = 0;
% end

end