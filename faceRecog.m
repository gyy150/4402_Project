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

% Last Modified by GUIDE v2.5 20-May-2016 12:57:33

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
[classSize, widthRes] = imageSetProp(handles.dirName);
set(handles.maxSize,'String',int2str(widthRes));

if classSize > 0
    set(handles.checkbox1,'visible','on')
    if classSize > 1
        set(handles.checkbox2,'visible','on')
        if classSize > 2
            set(handles.checkbox3,'visible','on')
            if classSize > 3
                set(handles.checkbox4,'visible','on')
                if classSize > 4
                    set(handles.checkbox5,'visible','on')
                    if classSize > 5
                        set(handles.checkbox6,'visible','on')
                        if classSize > 6
                            set(handles.checkbox7,'visible','on')
                            if classSize > 7
                                set(handles.checkbox8,'visible','on')
                                if classSize > 8
                                    set(handles.checkbox9,'visible','on')
                                    if classSize > 9
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

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


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
