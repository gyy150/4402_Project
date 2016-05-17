function image_vector = get_image_vector(imagePath, size)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
im = imread(imagePath);
im = imresize(im, [size size]);   %downsample the image 
im = mat2gray(im);
image_vector = im(:);
end

