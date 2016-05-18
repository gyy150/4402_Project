function [ class ] = getClass( imagePath , testData, scale)

class = []; % size 3 vector holding the class name, the dist and a image path from the class that is not the input image path

% turn image into vector
imVector = get_image_vector(cell2mat(imagePath) , scale);

% loop through class list and calc distances
for i = 1:size(testData,1)
    
    % get approx image vector
    X = testData{i,4};
    transX = X';
    H = X/(transX*X)*transX;
    approx_imVector = H*imVector;
    
    % calc distance
    dist = sqrt(sum((approx_imVector - imVector).^2));
    
    % make sure output image isnt the same
    %trainingPaths = classCell(2);
    %b = 1;
    %altPath = trainingPaths{1}(b);
    %while(strcmp(altPath,imagePath))
    %    b = b + 1;
    %    altPath = trainingPaths{1}(b);
    %end
    
    
    % update minDist if new dist is less
    if isempty(class) || dist < cell2mat(class(2))
        class = {testData{i}, dist};
            
    end
end

end


