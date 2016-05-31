function imageVector = getImageVector(imagePath, dsImHeight, dsImWidth)
% Reads image, downscales and converts to a column vector
%
% Inputs:   imagePath   - full file path of image to be columnised
%           dsImHeight  - height of downscaled image
%           dsImWidth   - width of downscaled image
%
% Output:   imageVector - dsImHeight*dsImWidth column vector
%
% Authors:  Bradley Byrne, Zachary Newman, Yiyang Gao

% Read and downscale image
im = imread(imagePath);
im = imresize(im, [dsImHeight dsImWidth]);

% Normalise and columnise image
im = im2double(im);
im = im - min(im(:));
im = im / max(im(:));
imageVector = im(:);

end