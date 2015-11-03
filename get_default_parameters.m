function p = get_default_parameters(numberOfAngles, numberOfSubdivision)
if nargin < 1
    numberOfAngles = 2;
elseif nargin < 2
    numberOfSubdivision = 8;
end
p = struct();
p.filter = struct();
p.filter.angles = pi*(1:numberOfAngles)/numberOfAngles;
p.filter.layerScale = 1./[2,2,2];
p.filter.layerSigma = [2,2,2];
p.extract = struct();
p.extract.sub_division = [1,1] * numberOfSubdivision;
p.extract.sigma = 6;  
end