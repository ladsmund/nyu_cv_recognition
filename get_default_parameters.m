function p = get_default_parameters()
numberOfAngles = 2;
p = struct();
p.filter = struct();
p.filter.angles = pi*(1:numberOfAngles)/numberOfAngles;
p.filter.layerScale = [2, 2,2];
p.filter.sigma = 2;
p.extract = struct();
p.extract.sub_division = [8,8];
p.extract.sigma = 6;  
end