function [test_data]= getAllFiles(dirName, selection, size)
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

    test_data = [];                                     % Initialize the regressor list array

    if ~isempty(fileList)
        image_vector = [];
        train_paths = {};
        test_paths = {};
        for i = 1:length(fileList)
            if any(i == selection)
                train_paths = [train_paths; fullfile(dirName,fileList{i})];
                file_name = fileList(i);
                image_vector = [image_vector get_image_vector(fullfile(dirName,fileList{i}), size)];          %stacking the image vector for each training image to build regressor
            else
                test_paths = [test_paths; fullfile(dirName,fileList{i})];
            end
        end
        % after the loop, the Regressor for this class is the now stacked image_vector;
    end
    
    
    if all(validIndex == 0)
        [~,name,~] = fileparts(dirName);
        test_data = {name, train_paths, test_paths, image_vector};    %recursion terminate here 
    else 
        for i = find(validIndex)                            % Loop over valid subdirectories 
        test_data = [test_data; getAllFiles(fullfile(dirName,subDirs{i}),selection,size)];       % Recursively call getAllFilesm, storing the regressor for each class in the regressor list
        end
    end
    
end

