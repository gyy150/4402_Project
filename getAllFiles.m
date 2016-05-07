function Regressor_list = getAllFiles(path, dirName)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    dirName = fullfile(path, dirName);                %# Get the full directory path
    dirData = dir(dirName);                           %# Get the data for the current directory
    disp('**************************************');
    disp(dirName);
    disp('**************************************');
    dirIndex = [dirData.isdir];                       %# Find the index for directories
    subDirs = {dirData(dirIndex).name}                %# Get a list of the subdirectories
    fileList = {dirData(~dirIndex).name}              %# Get a list of the files
    Regressor_list = [];                                  %# Initialize the regressor list array
    if ~isempty(fileList)
        image_vector = [];
        for i = [1 2 3 4 5]
            file_name = fileList(i);
            disp('**************************************');
            disp(char(file_name{1}));
            disp('**************************************');
            imshow(imread(fullfile(dirName,file_name{1})));
            image_vector = [image_vector get_image_vector(fullfile(dirName,file_name{1}))];          %#stacking the image vector for each training image to build regressor
        end
        
        %# after the loop, the Regressor for this class is the now stacked image_vector;
    end
    validIndex = ~ismember(subDirs,{'.','..'});      %# Find index of subdirectories that are not '.' or '..'
    if any(validIndex(:)>0) == 0                        %# if there is no subdirectory
        Regressor_list = image_vector                    %recursion terminate here
    else 
        for iDir = find(validIndex)                       %# Loop over valid subdirectories 
        Regressor_list = [Regressor_list; getAllFiles(dirName,subDirs{iDir})];       %# Recursively call getAllFilesm, storing the regressor for each class in the regressor list
        end
    end
    
    
end

