%# Testing script for the project. 
a = randperm(10);
selection = a(1:5);                               %the selection matrix for training, the index of image in selection will be used as trainning images
testing_image_index = a(6:10);                    %index for test8ing images, the left over images from selection matrix                      
size = 50;                                        %rescale size for trainning model
dir_name = uigetdir(pwd);                            %get the directory where image sets is at
Trainning_data = getAllFiles(dir_name, selection , size);   %get the trainned calss cell array by calling getAllFiles function






