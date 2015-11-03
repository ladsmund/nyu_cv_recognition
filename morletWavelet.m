function [kernel, psi] = morletWavelet(sigma, theta, radius)

if nargin < 3
    % A radius if size 3 * sigman ensures 99.9% of the areal/volumen
    radius = 2.5*sigma;
end

[eThetaX, eThetaY] = pol2cart(theta,1);
eTheta = [eThetaX, eThetaY];

% angleFrequency = 2*pi / (sigma * 2);
angleFrequency = 1 / sigma;

gauss = @(u) exp(-sum(u.^2,2) / (2 * sigma^2));
wave = @(u) exp(1i*angleFrequency*(u*eTheta'));

[X,Y] = meshgrid(-radius:radius);
us = [X(:), Y(:)];

C2 = sum(wave(us) .* gauss(us)) / sum(gauss(us));
psiUnNormalized = @(u) 1 / sigma * (wave(u) - C2) .* gauss(u);

C1 = 1 / sqrt(sum(sum(psiUnNormalized(us) .* conj(psiUnNormalized(us)))));

psi = @(u) C1 / sigma * (wave(u) - C2) .* gauss(u);

kernel = X;
kernel(:) = psi([X(:), Y(:)]);
end