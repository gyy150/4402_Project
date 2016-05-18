function [classSize, maxRes]= imageSetProp(dirName)

    dirData = dir(dirName);                             % Get the data for the current directory
    dirIndex = [dirData.isdir];                         % Find the index for directories
    fileList = {dirData(~dirIndex).name};               % Get a list of the files
    subDirs = {dirData(dirIndex).name};                 % Get a list of the subdirectories
    validIndex = ~ismember(subDirs,{'.','..'});         % Find index of subdirectories that are not '.' or '..'
    
    
    
end