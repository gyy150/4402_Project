function image_vector = get_image_vector( image )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
im = imread(image);
im = imresize(im,[10 10]);   %downsample the image 
im = mat2gray(im);
image_vector = im(:);


end

