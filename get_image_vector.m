function image_vector = get_image_vector(imagePath, size)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
im = imread(imagePath);
% Downscale image
im = imresize(im, [size size]);   %downsample the image 
% Convert to greyscale
im = mat2gray(im);
im = (im - min(min(im)))*255/(max(max(im)) - min(min(im)));
image_vector = im(:);
end