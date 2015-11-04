function p = get_default_parameters(numberOfAngles, numberOfSubdivision,layers)
if nargin < 1
    numberOfAngles = 4;
end
if nargin < 2
    numberOfSubdivision = 4;
end
if nargin < 3
    layers = 1;
end
p = struct();
p.filter = struct();
p.filter.angles = pi*(1:numberOfAngles)/numberOfAngles;
p.filter.sigmas = [2,6,10];
p.filter.layers = layers;
p.extract = struct();
p.extract.sub_division = [1,1] * numberOfSubdivision;
p.extract.sigma = 6;  
end