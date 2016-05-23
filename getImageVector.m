function imageVector = getImageVector(imagePath, dsImHeight, dsImWidth)

im = imread(imagePath);
% Downscale image
im = imresize(im, [dsImHeight dsImWidth]);
im = im2double(im);
im = im - min(im(:));
im = im / max(im(:));
imageVector = im(:);
end