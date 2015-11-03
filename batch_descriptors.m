function descriptors_struct = batch_descriptors(input_path, parameters)

if nargin < 2
    parameters = get_default_parameters();
end

%%

input_root = dir(input_path);

subfolder_filter = [input_root.isdir];
subfolder_filter(1:2) = 0; % Remove self and parent folder
folders = input_root(subfolder_filter);

classes = {folders.name}
descriptors = cell(length(classes),1);

for c = 1:length(classes)
    class = classes{c};
    class_path =[input_path class '/*.pgm'];    
    images_dir = dir(class_path);
    
    descriptor = cell(length(images_dir),1);
    
    parfor i = 1:length(images_dir)
        image_name = images_dir(i).name;
        fprintf('class: %s, image: %s\n', class, image_name)
        image_path = [input_path class '/' image_name];
        
        img = double(imread(image_path));
        descriptor{i} = generateDescriptor(img, parameters);                
    end
        
    descriptors{c} = cat(2,descriptor{:});  
end


descriptors_struct = struct();
descriptors_struct.classes = classes;
descriptors_struct.descriptors = descriptors;

end




