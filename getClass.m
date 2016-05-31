function [predClassNum] = getClass(imagePath , testData, dsImHeight, dsImWidth)
% Takes a image path and test data and rescale demenisons and returns the
% class number of the class with the closest regression distance to the
% image.
%
% Inputs:   imagePath     - full file path of test image
%           testData      - cell array of all testData
%           dsImHeight    - height of downscaled image
%           dsImWidth     - width of downscaled image
%
% Output:   predClassNum  - class number of predicted class
%
% Authors:  Bradley Byrne, Zachary Newman, Yiyang Gao

% Turn image into downscaled vector
imVector = getImageVector(imagePath, dsImHeight, dsImWidth);

% Loop through class list and calculate distances
for ii = 1:size(testData,1)
    
    % Get predicted image vector
    X = testData{ii,4};
    transX = X';
    H = X/(transX*X)*transX;
    predImVector = H*imVector;
    
    % Calculate distance
    dist = sqrt(sum((imVector - predImVector).^2));
    
    % Update minDist and predicted class if new dist is less than minDist
    if ii == 1 || dist < minDist
        predClassNum = ii;
        minDist = dist;
    end
end

end
