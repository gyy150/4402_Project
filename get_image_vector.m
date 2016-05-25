function imageVector = getImageVector(imagePath, dsImHeight, dsImWidth)
% takes a image path and the down scale values for width and height and
% rescales, normalizes and outputs a column vector of the image

% read image
im = imread(imagePath);

% Downscale image
im = imresize(im, [dsImHeight dsImWidth]);
im = im2double(im);

% normailize image
im = im - min(im(:));
im = im / max(im(:));

imageVector = im(:);
end