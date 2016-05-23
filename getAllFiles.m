function [testData]= getAllFiles(dirName, selection, dsImHeight, dsImWidth)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here?????

% Inputs:   dirName   - directory path with all images contained
%           selection - selection criteria for sorting to train and test
%           size      - size to downscale images to

% Output:   cell array - size: 4 * number of classes
%               col1 - class name
%               col2 - paths of all training images
%               col3 - paths of all testing images
%               col4 - class regressor
    
    dirData = dir(dirName);                             % Get the data for the current directory
    dirIndex = [dirData.isdir];                         % Find the index for directories
    fileList = {dirData(~dirIndex).name};               % Get a list of the files
    subDirs = {dirData(dirIndex).name};                 % Get a list of the subdirectories
    validIndex = ~ismember(subDirs,{'.','..'});         % Find index of subdirectories that are not '.' or '..'

    testData = [];                                     % Initialize the regressor list array

    if ~isempty(fileList)
        imageVector = zeros(dsImHeight*dsImWidth, length(selection));
        trainPaths = fullfile(dirName, fileList(selection)).';
        notSelection = setdiff(1:10, selection);
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