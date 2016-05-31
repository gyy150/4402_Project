function [classSize, heightRes, widthRes] = imageSetProp(dirName)
% Read image dataset directory to determine class size and image dimensions
% in order to populate GUI values
%
% Inputs:   dirName     - directory path with all images contained
%
% Output:   classSize   - number of images in class
%           heightRes   - height of images
%           widthRes    - width of images
%
% Authors:  Bradley Byrne, Zachary Newman, Yiyang Gao

% Get the subdirectories for the current directory
dirData = dir(dirName);
dirIndex = [dirData.isdir];
subDirs = {dirData(dirIndex).name};
validIndex = ~ismember(subDirs,{'.','..'});

% Read the first subdirectory and determine classSize
subDirList = find(validIndex);
subDir1 = fullfile(dirName,subDirs{subDirList(1)});
subDirData = dir(subDir1);
subDirIndex = [subDirData.isdir];              
subFileList = {subDirData(~subDirIndex).name};
classSize = length(subFileList);

% Find first image resolution
imString = fullfile(subDir1, subFileList(1));
testIm = imread(imString{1});
[heightRes, widthRes] = size(testIm);

end