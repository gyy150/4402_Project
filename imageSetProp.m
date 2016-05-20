function [classSize, widthRes] = imageSetProp(dirName)

    dirData = dir(dirName);                             % Get the data for the current directory
    dirIndex = [dirData.isdir];                         % Find the index for directories
    fileList = {dirData(~dirIndex).name};               % Get a list of the files
    subDirs = {dirData(dirIndex).name};                 % Get a list of the subdirectories
    validIndex = ~ismember(subDirs,{'.','..'});         % Find index of subdirectories that are not '.' or '..'
    
    subDirList = find(validIndex);
    subDir1 = fullfile(dirName,subDirs{subDirList(1)});
    
    subDirData = dir(subDir1);                             % Get the data for the current directory
    subDirIndex = [subDirData.isdir];                         % Find the index for directories
    subFileList = {subDirData(~subDirIndex).name};               % Get a list of the files
    
    classSize = length(subFileList);
    
    imString = fullfile(subDir1, subFileList(1));
    testIm = imread(imString{1});
    [~, widthRes] = size(testIm);

end