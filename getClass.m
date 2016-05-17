function [ class ] = getClass( imagePath , testData)

class = []; % size 3 vector holding the class name, the dist and a image path from the class that is not the input image path

% turn image into vector
imVector = get_image_vector(imagePath , size);

% loop through class list and calc distances
for i = 1:size(testData,1)
    
    % get approx image vector
    X = cell2mat(testData(i,4));
    H = X*inv(X'*X)*X';
    approx_imVector = H*imVector;
    
    % calc distance
    dist = sqrt(sum((approx_imVector - imVector).^2));
    
    % update minDist if new dist is less
    if isempty(class) || dist < cell2mat(class(2))
        
        trainingPaths = cell2mat(testData(i,2));
        class = [testData(i,1), dist, trainingPaths(1)];
      
        % make sure output image isnt the same
        b = 2;
        while(strcmp(class(3),imagePath))
            class(3) = trainingPaths(b);
            b = b + 1;
        end
            
    end
end

end


