% Testing script for the project.
%**************************************************************************
%initializting all variables

a = randperm(10);
selection = a(1:5);                               %the selection matrix for training, the index of image in selection will be used as trainning images
%testing_Image_Index = a(6:10);                    %index for test8ing images, the left over images from selection matrix                      
size = 50;                                        %rescale size for trainning model
dirName = uigetdir(pwd);                            %get the directory where image sets is at, starting path is the current path
Trainning_data = getAllFiles(dir_name, selection , size);   %get the trainned calss cell array by calling getAllFiles function

%**************************************************************************
result = [];
class = {};
length = length(cellfun('length', Trainning_data));     %get the length of the cell array, which is the number of classes in the image sets
for i = 1:length
    counter = 0;                                        %counter for number of sucess detection  
    class_name =  Trainning_data{i,1};                  %class name of this testing image
    for j = 1:5
       file_path =  Trainning_data{i,3}{j};
       result = getClass(file_path, Trainning_data );%result from getClass function.
       detected_class_name = result(1);              %the class name as detected
       distance = result(2);
       if strcmp(detected_class_name,class_name );  %if correct
           counter = counter +1;
       end
    end
    result(i) = counter;                      %put number of sucess of this class
    class{i} = class_name;
end

bar(result);
Labels = class;
set(gca, 'XTick', 1:4, 'XTickLabel', class);

