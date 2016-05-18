% Testing script for the project.

% constants
fileSize = 10;
numTrainingImages = 5;
scale = 50; 
selection = randperm(fileSize, numTrainingImages);

% get test data                
dirName = uigetdir(pwd);                                    
testData = getAllFiles(dirName, selection , scale);   

result = [];
classes = {};
numClasses = size(testData,1);

% loop through classes in test data
for i = 1:numClasses
    
    counter = 0;
    class_name =  testData{i,1};
    
    % get test paths
    testPaths = testData{i,3};
    numTestImages = size(testData{i,3},1);
    
    % for each test image calc class and check if correct 
    for j = 1:numTestImages
       file_path =  testPaths(j);
       class = getClass(file_path, testData ,scale);%result from getClass function.
       detected_class_name = cell2mat(class(1));              %the class name as detected
       distance = cell2mat(class(2));
       if strcmp(detected_class_name,class_name );  %if correct
           counter = counter +1;
       end
    end
    result(i) = counter                      %put number of sucess of this class
    classes{i} = class_name;
end

bar(result);
Labels = class;
set(gca, 'XTick', 1:4, 'XTickLabel', class);

