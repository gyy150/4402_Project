function [Regressor_list]= getAllFiles(dirName, selection, size)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here?????
% the return value regressor is a N*2 cell array, N being the number of class in the director
% for each row, the first element in the cell is the regressor matrix,
% while the second one is the class name
    
    dirData = dir(dirName);                           % Get the data for the current directory
    dirIndex = [dirData.isdir];                       % Find the index for directories
    fileList = {dirData(~dirIndex).name};             % Get a list of the files
    subDirs = {dirData(dirIndex).name};               % Get a list of the subdirectories
    validIndex = ~ismember(subDirs,{'.','..'});       % Find index of subdirectories that are not '.' or '..'

                                                      % a patern spercifying the index of image within a class that shall be used as trainning image
                                                      % each class is identified by it's folder's name
    Regressor_list = [];                              % Initialize the regressor list array
   
    if ~isempty(fileList)
        image_vector = [];
        for i = selection
            file_name = fileList(i);
            image_vector() = [image_vector get_image_vector(fullfile(dirName,file_name{1}))];          %#stacking the image vector for each training image to build regressor
        end
        
        %# after the loop, the Regressor for this class is the now stacked image_vector;
    end
    if any(validIndex(:)>0) == 0                        % if there is no subdirectory
        Regressor_list = {image_vector ,  className};    %recursion terminate here 
    else 
        for iDir = find(validIndex)                       % Loop over valid subdirectories 
        Regressor_list = [Regressor_list; getAllFiles(dirName,subDirs{iDir})];       % Recursively call getAllFilesm, storing the regressor for each class in the regressor list
        end
    end    
end

