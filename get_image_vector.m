function image_vector = get_image_vector(imagePath, size)

im = imread(imagePath);
% Downscale image
im = imresize(im, [size size]);   %downsample the image 

im = (im - min(min(im)))*255/(max(max(im)) - min(min(im)));
image_vector = im(:);
end