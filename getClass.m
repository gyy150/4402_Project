function [predClassNum] = getClass(imagePath , testData, dsImHeight, dsImWidth)
% takes a image path and test data and rescale demenisons and returns the
% class number of the class with the closest regression distance to the
% image.

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
    
    % update minDist if new dist is less
    if ii == 1 || dist < minDist
        predClassNum = ii;
        minDist = dist;
    end
end

end
