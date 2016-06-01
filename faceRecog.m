function varargout = faceRecog(varargin)
% FACERECOG MATLAB code for faceRecog.fig
%      FACERECOG, by itself, creates a new FACERECOG or raises the existing
%      singleton*.
%
%      H = FACERECOG returns the handle to a new FACERECOG or the handle to
%      the existing singleton*.
%
%      FACERECOG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACERECOG.M with the given input arguments.
%
%      FACERECOG('Property','Value',...) creates a new FACERECOG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before faceRecog_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to faceRecog_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help faceRecog

% Last Modified by GUIDE v2.5 01-Jun-2016 16:28:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @faceRecog_OpeningFcn, ...
                   'gui_OutputFcn',  @faceRecog_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before faceRecog is made visible.
function faceRecog_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to faceRecog (see VARARGIN)

% Choose default command line output for faceRecog
handles.output = hObject;

% Hide all axes
set(handles.testIm,'visible','off') 
set(handles.predIm,'visible','off') 
set(handles.graph,'visible','off') 
set(handles.border,'visible','off')

% Hide selection check boxes
for ii = 1:10
    set(handles.(sprintf('checkbox%d',ii)),'visible','off');
end

% Disable slider bar and checkboxes
set(handles.downSize,'Enable','off')
set(handles.square,'Enable','off')
set(handles.lockAR,'Enable','off')
set(handles.tenByFive, 'Enable', 'off')

% Set square checkbox to selected
set(handles.square,'value', 1)

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = faceRecog_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in dataSel.
function dataSel_Callback(hObject, eventdata, handles)
% hObject    handle to dataSel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Create file explorer for opening file
handles.dirName  = uigetdir('.\*.*','Please select an image dataset directory to load');
if isequal(handles.dirName,0)
    return
end
[~, onlyDir, ~] = fileparts(handles.dirName);

% Retrieve the class size and image size
[handles.classSize, handles.heightRes, handles.widthRes] = imageSetProp(handles.dirName);
set(handles.maxSize,'String', handles.widthRes);

% Retrieve the slider value
currVal = floor(get(handles.downSize, 'value')*handles.widthRes);
if (currVal < 2)
    currVal = 2;
end

% Set values to either square, locked aspect ratio or 10x5
if get(handles.square, 'Value');
    % Enable the slider
    set(handles.downSize,'Enable','on')
    
    set(handles.sldrCurr,'Value', currVal);
    set(handles.sldrCurr,'String', currVal);
    set(handles.sldrCurrH,'Value', currVal);
    set(handles.sldrCurrH,'String', currVal);
elseif get(handles.lockAR, 'Value')
    % Enable the slider
    set(handles.downSize,'Enable','on')
    
    set(handles.sldrCurr,'Value', currVal);
    set(handles.sldrCurr,'String', currVal);
    height = floor(get(handles.sldrCurr, 'Value')*handles.heightRes/handles.widthRes);
    set(handles.sldrCurrH,'Value', height);
    set(handles.sldrCurrH,'String', height);
else
    % Disable the slider
    set(handles.downSize,'Enable','off')
    
    set(handles.sldrCurr,'Value', 5);
    set(handles.sldrCurr,'String', 5);
    set(handles.sldrCurrH,'Value', 10);
    set(handles.sldrCurrH,'String', 10);
end

% Show the correct number of checkboxes and set all to unchecked
for ii = 1:10
    set(handles.(sprintf('checkbox%d',ii)),'value', 0)
    if handles.classSize > ii - 1
        set(handles.(sprintf('checkbox%d',ii)),'visible','on')
    else
        set(handles.(sprintf('checkbox%d',ii)),'visible','off')
    end
end

% Enable checkboxes
set(handles.square,'Enable','on')
set(handles.lockAR,'Enable','on')
set(handles.tenByFive,'Enable','on')

% Display directory name
set(handles.datasetText,'String',onlyDir);

% Update handles structure
guidata(hObject, handles);


% --- Executes on slider movement.
function downSize_Callback(hObject, eventdata, handles)
% hObject    handle to downSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get the slider value
currVal = floor(get(handles.downSize, 'value')*handles.widthRes);

if (currVal < 2)
    currVal = 2;
end

% Set values to either square or locked aspect ratio
if get(handles.square, 'Value');
    set(handles.sldrCurr,'Value', currVal);
    set(handles.sldrCurr,'String', currVal);
    set(handles.sldrCurrH,'Value', currVal);
    set(handles.sldrCurrH,'String', currVal);
else
    set(handles.sldrCurr,'Value', currVal);
    set(handles.sldrCurr,'String', currVal);
    height = floor(get(handles.sldrCurr, 'Value')*handles.heightRes/handles.widthRes);
    set(handles.sldrCurrH,'Value', height);
    set(handles.sldrCurrH,'String', height);
end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function downSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to downSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in simulate.
function simulate_Callback(hObject, eventdata, handles)
% hObject    handle to simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Error message if no dataset is selected
if ~isfield(handles, 'dirName')
    set(handles.errorText,'String', 'No dataset selected');
    return
else
    set(handles.errorText,'String', '');
end

% Get the status of all checkboxes and determine selection
checkboxArray = zeros(1,handles.classSize);
for ii = 1:10
    checkboxArray(ii) = get(handles.(sprintf('checkbox%d', ii)), 'Value');
end

% Error if no train images are selected or all are selected
if all(checkboxArray == 0)
    set(handles.errorText,'String','At least one image must be used for training')
    return
elseif all(checkboxArray(1:handles.classSize) == 1)
    set(handles.errorText,'String','At least one image must be used for testing')
    return
end

selection = find(checkboxArray);

% Find all the data of the test directory
testData = getAllFiles(handles.dirName, selection , get(handles.sldrCurrH, 'Value'), get(handles.sldrCurr, 'Value'));

numClasses = size(testData, 1);
numTestIm = length(testData{1,3});
result = zeros(1,numTestIm*numClasses);
mu = zeros(1,numTestIm*numClasses);

% Loop through classes for face recognition
for ii = 1:numClasses
   
    % Get test paths
    testPaths = testData{ii,3};
    
    % For each test image calc class and check if correct 
    for jj = 1:numTestIm
       filePath = testPaths{jj};
       
       % Show test image in first axes
       testImage = imread(filePath);
       axes(handles.testIm);
       imshow(testImage);
       drawnow;
       
       % Find the predicted class and the first train image from class
       [predClassNum] = getClass(filePath, testData , get(handles.sldrCurrH, 'Value'), get(handles.sldrCurr, 'Value'));
       predImage = imread(testData{predClassNum, 2}{1});
       
       % Display depending on whether the correct predicted image
       if predClassNum == ii
           result((ii-1)*numTestIm + jj) = 1;
           set(handles.border, 'Color', [0.2 0.8 0.2],'visible','on', 'box','off','xtick',[],'ytick',[],'ztick',[],'xcolor',[1 1 1],'ycolor',[1 1 1]);
           axes(handles.predIm);
           imshow(predImage);
           drawnow;
       else
           result((ii-1)*numTestIm + jj) = 0;
           set(handles.border, 'Color',[0.8 0.2 0.2],'visible','on', 'box','off','xtick',[],'ytick',[],'ztick',[],'xcolor',[1 1 1],'ycolor',[1 1 1]);
           axes(handles.predIm);
           imshow(predImage);
           drawnow;
       end
       
       % Calculate the average detection rate after each face
       mu((ii-1)*numTestIm + jj) = 100*mean(result(1:(ii-1)*numTestIm + jj));
       
       % Plot bar graph of individual results and average line
       axes(handles.graph);
       [AX, H1, H2] = plotyy(1:length(result), result, 1:((ii-1)*numTestIm + jj), mu(1:(ii-1)*numTestIm + jj), 'bar','line');
       set(AX(1),'YLim',[0 1])
       set(AX(1),'XLim',[0.5 numTestIm*numClasses+0.5])
       set(AX(1),'xtick',[1 numTestIm*numClasses])
       set(AX(1),'ytick',[])
       set(AX(2),'YLim',[0 100])
       set(AX(2),'XLim',[0.5 numTestIm*numClasses+0.5])
       set(AX(2),'ytick',0:10:100)
       xlabel('Test Image Number')
       set(get(AX(2),'Ylabel'),'string','Accuracy (%)')
       set(H1, 'FaceColor', [0.8, 0.8, 0.8])
       set(H1, 'EdgeColor', 'none')
       set(H2, 'LineWidth', 3)
       drawnow;
       
       % Display running average
       set(handles.accuracy, 'String', sprintf('%0.1f',(mu((ii-1)*numTestIm + jj))));
    end
end


% --- Executes on button press in lockAR.
function lockAR_Callback(hObject, eventdata, handles)
% hObject    handle to lockAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Enable the slider
set(handles.downSize,'Enable','on')

% Get the state of the checkbox
state = get(hObject,'Value');

% Retrieve the slider value
currVal = floor(get(handles.downSize, 'value')*handles.widthRes);
if (currVal < 2)
    currVal = 2;
end

% Only one checkbox can be selected at a time and adjust resolution values
% accordingly
if state == 0
    set(handles.square,'Value',1)
    set(handles.tenByFive,'Value',0)
    
    % Set height and width
    set(handles.sldrCurr,'Value', currVal);
    set(handles.sldrCurr,'String', currVal);
    set(handles.sldrCurrH,'Value', currVal);
    set(handles.sldrCurrH,'String', currVal);
else
    set(handles.square,'Value',0)
    set(handles.tenByFive,'Value',0)
    height = floor(currVal*handles.heightRes/handles.widthRes);
    
    % Set height and width
    set(handles.sldrCurr,'Value', currVal);
    set(handles.sldrCurr,'String', currVal);
    set(handles.sldrCurrH,'Value', height);
    set(handles.sldrCurrH,'String', height);
end



% --- Executes on button press in square.
function square_Callback(hObject, eventdata, handles)
% hObject    handle to square (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Enable the slider
set(handles.downSize,'Enable','on')

% Get the state of the checkbox
state = get(hObject,'Value');

% Retrieve the slider value
currVal = floor(get(handles.downSize, 'value')*handles.widthRes);
if (currVal < 2)
    currVal = 2;
end

% Only one checkbox can be selected at a time and adjust resolution values
% accordingly
if state == 0
    set(handles.lockAR,'Value',1)
    set(handles.tenByFive,'Value',0)
    height = floor(currVal*handles.heightRes/handles.widthRes);
    
    % Set height and width
    set(handles.sldrCurr,'Value', currVal);
    set(handles.sldrCurr,'String', currVal);
    set(handles.sldrCurrH,'Value', height);
    set(handles.sldrCurrH,'String', height);
else
    set(handles.lockAR,'Value',0)
    set(handles.tenByFive,'Value',0)
    
    % Set height and width
    set(handles.sldrCurr,'Value', currVal);
    set(handles.sldrCurr,'String', currVal);
    set(handles.sldrCurrH,'Value', currVal);
    set(handles.sldrCurrH,'String', currVal);
end


% --- Executes on button press in tenByFive.
function tenByFive_Callback(hObject, eventdata, handles)
% hObject    handle to tenByFive (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Disable the slider
set(handles.downSize,'Enable','on')

% Get the state of the checkbox
state = get(hObject,'Value');

% Retrieve the slider value
currVal = floor(get(handles.downSize, 'value')*handles.widthRes);
if (currVal < 2)
    currVal = 2;
end

% Only one checkbox can be selected at a time and adjust resolution values
% accordingly
if state == 0
    set(handles.lockAR,'Value',1)
    set(handles.square,'Value',0)
    height = floor(currVal*handles.heightRes/handles.widthRes);
    
    % Set height and width
    set(handles.sldrCurr,'Value', currVal);
    set(handles.sldrCurr,'String', currVal);
    set(handles.sldrCurrH,'Value', height);
    set(handles.sldrCurrH,'String', height);
    
else
    % Disable the slider
    set(handles.downSize,'Enable','off')
    
    % Uncheck other boxes
    set(handles.lockAR,'Value',0)
    set(handles.square,'Value',0)
    
    % Set height and width
    set(handles.sldrCurr,'Value', 5);
    set(handles.sldrCurr,'String', 5);
    set(handles.sldrCurrH,'Value', 10);
    set(handles.sldrCurrH,'String', 10);
end
