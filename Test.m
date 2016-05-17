% Testing script for the project.
%**************************************************************************
%initializting all variables

a = randperm(10);
selection = a(1:5);                               %the selection matrix for training, the index of image in selection will be used as trainning images
testing_Image_Index = a(6:10);                    %index for test8ing images, the left over images from selection matrix                      
size = 50;                                        %rescale size for trainning model
dirName = uigetdir(pwd);                            %get the directory where image sets is at, starting path is the current path
Trainning_data = getAllFiles(dirName, selection , size);   %get the trainned calss cell array by calling getAllFiles function

%**************************************************************************
%recursively treaversing through all image set to test the system

dirData = dir(dirName);                           % Get the data for the current directory
dirIndex = [dirData.isdir];                       % Find the index for directories
fileList = {dirData(~dirIndex).name};             % Get a list of the files
subDirs  = {dirData(dirIndex).name};               % Get a list of the subdirectories
validIndex = ~ismember(subDirs,{'.','..'});       % Find index of subdirectories that are not '.' or '..'
if ~isempty(fileList)
    for i = testing_Image_Index                     %treaverse through every testing image in the image stes folder
       file_name = fileList(i);
       file_path = fullfile(dirName,file_name{1});  %the full path of the iamge to be tested
       result = getClass(file_path, Trainning_data );%result from getClass function.
       detected_class_name = result(1);              %the class name as detected
       distance = result(2);
       
    end
end


