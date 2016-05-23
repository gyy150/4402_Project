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

% Last Modified by GUIDE v2.5 23-May-2016 09:05:01

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

% Hide axes
set(handles.testIm,'visible','off') 
set(handles.predIm,'visible','off') 
set(handles.graph,'visible','off') 

% Hide check boxes
set(handles.checkbox1,'visible','off')
set(handles.checkbox2,'visible','off') 
set(handles.checkbox3,'visible','off') 
set(handles.checkbox4,'visible','off')
set(handles.checkbox5,'visible','off') 
set(handles.checkbox6,'visible','off') 
set(handles.checkbox7,'visible','off')
set(handles.checkbox8,'visible','off') 
set(handles.checkbox9,'visible','off') 
set(handles.checkbox10,'visible','off')

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
[~, onlyDir, ~] = fileparts(handles.dirName);

% Retrieve the class size and image size
[handles.classSize, handles.widthRes] = imageSetProp(handles.dirName);
set(handles.maxSize,'String',handles.widthRes);
set(handles.sldrCurr,'String',get(handles.downSize, 'value')*handles.widthRes);

% Hide check boxes
set(handles.checkbox1,'visible','off')
set(handles.checkbox2,'visible','off') 
set(handles.checkbox3,'visible','off') 
set(handles.checkbox4,'visible','off')
set(handles.checkbox5,'visible','off') 
set(handles.checkbox6,'visible','off') 
set(handles.checkbox7,'visible','off')
set(handles.checkbox8,'visible','off') 
set(handles.checkbox9,'visible','off') 
set(handles.checkbox10,'visible','off')

if handles.classSize > 0
    set(handles.checkbox1,'visible','on')
    if handles.classSize > 1
        set(handles.checkbox2,'visible','on')
        if handles.classSize > 2
            set(handles.checkbox3,'visible','on')
            if handles.classSize > 3
                set(handles.checkbox4,'visible','on')
                if handles.classSize > 4
                    set(handles.checkbox5,'visible','on')
                    if handles.classSize > 5
                        set(handles.checkbox6,'visible','on')
                        if handles.classSize > 6
                            set(handles.checkbox7,'visible','on')
                            if handles.classSize > 7
                                set(handles.checkbox8,'visible','on')
                                if handles.classSize > 8
                                    set(handles.checkbox9,'visible','on')
                                    if handles.classSize > 9
                                        set(handles.checkbox10,'visible','on')
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

% Display directory name
set(handles.datasetText,'String',onlyDir);

% Update handles structure
guidata(hObject, handles);


% --- Executes on slider movement.
function downSize_Callback(hObject, eventdata, handles)
% hObject    handle to downSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.sldrCurr,'String',uint8(get(handles.downSize, 'value')*handles.widthRes));

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

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4


% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox5


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9


% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox10


% --- Executes on button press in simulate.
function simulate_Callback(hObject, eventdata, handles)
% hObject    handle to simulate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Testing script for the project.

% constants
cb1 = get(handles.checkbox1, 'Value');
cb2 = get(handles.checkbox2, 'Value');
cb3 = get(handles.checkbox3, 'Value');
cb4 = get(handles.checkbox4, 'Value');
cb5 = get(handles.checkbox5, 'Value');
cb6 = get(handles.checkbox6, 'Value');
cb7 = get(handles.checkbox7, 'Value');
cb8 = get(handles.checkbox8, 'Value');
cb9 = get(handles.checkbox9, 'Value');
cb10 = get(handles.checkbox10, 'Value');

checkboxList = [cb1 cb2 cb3 cb4 cb5 cb6 cb7 cb8 cb9 cb10];
selection = find(checkboxList);

%numTrainingImages = 5;
%scale = 50; 
%selection = randperm(handles.classSize, numTrainingImages);

% get test data                
%dirName = uigetdir(pwd);                                    
testData = getAllFiles(handles.dirName, selection , str2num(get(handles.sldrCurr, 'String')));   

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
       class = getClass(file_path, testData , str2num(get(handles.sldrCurr, 'String')));%result from getClass function.
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

