function [ dist , altPath ] = cmpClass( imVector, imagePath, classCell )

    % get approx image vector
    X = cell2mat(classCell(4));
    H = X*inv(X'*X)*X';
    approx_imVector = H*imVector;
    
    % calc distance
    dist = sqrt(sum((approx_imVector - imVector).^2));
    
    % make sure output image isnt the same
    trainingPaths = classCell(2);
    b = 1;
    altPath = trainingPaths{b};
    while(strcmp(altPath,imagePath))
        b = b + 1;
        altPath = trainingPaths{b};
    end
end

