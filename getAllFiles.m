function [testData]= getAllFiles(dirName, selection, dsImHeight, dsImWidth)
% Read image dataset directory, sorts and returns data for facial
% recognition
%
% Inputs:   dirName     - directory path with all images contained
%           selection   - selection criteria for sorting to train and test
%           dsImHeight  - image downscale width
%           dsImHeight  - image downscale height

% Output:   cell array  - size: 4 * number of classes
%                  col1 - class name (e.g. s1, s2 ... sN)
%                  col2 - paths of all training images in each class
%                  col3 - paths of all testing images in each class
%                  col4 - class regressor matrix of columnised train images
%
% Authors:  Bradley Byrne, Zachary Newman, Yiyang Gao
    

% Get the data for the current directory -> files and subdirectories
dirData = dir(dirName);
dirIndex = [dirData.isdir];
fileList = {dirData(~dirIndex).name};   
subDirs = {dirData(dirIndex).name}; 
validIndex = ~ismember(subDirs,{'.','..'});

testData = [];     

% For files in directory find class name, file names of train and test
% images and create regressor array
if ~isempty(fileList)
    imageVector = zeros(dsImHeight*dsImWidth, length(selection));
    trainPaths = fullfile(dirName, fileList(selection)).';
    notSelection = setdiff(1:10, selection);
    testPaths = fullfile(dirName, fileList(notSelection)).';
    for ii = find(selection)
        imageVector(:,ii) = getImageVector(fullfile(dirName, fileList{ii}), dsImHeight, dsImWidth);
    end
end

% Recursively call getAllFiles for each sub-directory
if any(validIndex == 1)
    for ii = find(validIndex)
        testData = [testData; getAllFiles(fullfile(dirName,subDirs{ii}), selection, dsImHeight, dsImWidth)];
    end
% Recursion termination
else 
    [~,className,~] = fileparts(dirName);
    testData = {className, trainPaths, testPaths, imageVector};
    
end