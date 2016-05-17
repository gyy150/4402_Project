function [ class ] = getClass( imagePath , testData, size)

class = []; % size 3 vector holding the class name, the dist and a image path from the class that is not the input image path

% turn image into vector
imVector = get_image_vector(imagePath , size);

% loop through class list and calc distances
for i = 1:size(testData,1)
    
    [dist, altPath] = cmpClass(imVector, imagePath, testData(i));
    seenPaths
    
    % update minDist if new dist is less
    if isempty(class) || dist < cell2mat(class(2))
        class = [testData{1}(i), dist, altPath];
            
    end
end

end


