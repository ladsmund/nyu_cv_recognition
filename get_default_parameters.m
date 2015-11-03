function p = get_default_parameters(numberOfAngles, numberOfSubdivision)
if nargin < 1
    numberOfAngles = 4;
elseif nargin < 2
    numberOfSubdivision = 4;
end
p = struct();
p.filter = struct();
p.filter.angles = pi*(1:numberOfAngles)/numberOfAngles;
p.filter.sigmas = [2,6,10];
p.filter.layers = 2;
p.extract = struct();
p.extract.sub_division = [1,1] * numberOfSubdivision;
p.extract.sigma = 6;  
end