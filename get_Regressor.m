function [ className ] = get_image_vector( image , regressor_list )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

minDist = []; % size 2 vector holding max dist and its corrisponding class name
%distances = []; %  Nx2 matrix, with N classes long storing the distance value in the first cell and the class name in the second   

% turn image into vector
imVector = get_image_vector(image);

% loop through class list and calc distances
for i = 1:size(regressor_list,1)
    
    % get approx image vector
    X = cell2mat(regressor_list(i,1));
    H = X*inv(X'*X)*X';
    approx_imVector = H*imVector;
    
    % calc distance
    dist = sqrt(sum((approx_imVector - imVector).^2));
    
    % update minDist if new dist is less
    if isempty(minDist) || dist < cell2mat(minDist(1))
        minDist = [dist, regressor_list(i,2)];   
    end
end

className = minDist(2);

end


