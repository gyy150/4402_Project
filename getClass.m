function [predClassNum, minDist] = getClass(imagePath , testData, dsImHeight, dsImWidth)

% size 3 vector holding the class name, the dist and a image path from the class that is not the input image path

% turn image into vector
imVector = getImageVector(imagePath, dsImHeight, dsImWidth);

% loop through class list and calc distances

for ii = 1:size(testData,1)
    
    % get approx image vector
    X = testData{ii,4};
    transX = X';
    H = X/(transX*X)*transX;
    approxImVector = H*imVector;
    
    % calc distance
    dist = sqrt(sum((approxImVector - imVector).^2));
    
    % make sure output image isnt the same
    %trainingPaths = classCell(2);
    %b = 1;
    %altPath = trainingPaths{1}(b);
    %while(strcmp(altPath,imagePath))
    %    b = b + 1;
    %    altPath = trainingPaths{1}(b);
    %end
    
    
    % update minDist if new dist is less
    if ii == 1 || dist < minDist
        predClassNum = ii;
        minDist = dist;
    end
end
end
