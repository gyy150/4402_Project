function [testData]= getAllFiles(dirName, selection, dsImHeight, dsImWidth)
% Scans image dataset directory, sorts and returns data for facial
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

% Initialize the regressor list array
testData = [];     

% For 
if ~isempty(fileList)
    imageVector = zeros(dsImHeight*dsImWidth, length(selection));
    trainPaths = fullfile(dirName, fileList(selection)).';
    notSelection = setdiff(1:length(fileList), selection);
    testPaths = fullfile(dirName, fileList(notSelection)).';
    for ii = find(selection)
        imageVector(:,ii) = getImageVector(fullfile(dirName, fileList{ii}), dsImHeight, dsImWidth);
    end
end

if any(validIndex == 1)
    for ii = find(validIndex)                            % Loop over valid subdirectories 
        testData = [testData; getAllFiles(fullfile(dirName,subDirs{ii}), selection, dsImHeight, dsImWidth)];       % Recursively call getAllFilesm, storing the regressor for each class in the regressor list
    end
else 
    [~,className,~] = fileparts(dirName);
    testData = {className, trainPaths, testPaths, imageVector};    %recursion terminate here 
end
    
end