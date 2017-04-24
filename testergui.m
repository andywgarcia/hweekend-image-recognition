function varargout = testergui(varargin)
% TESTERGUI MATLAB code for testergui.fig
%      TESTERGUI, by itself, creates a new TESTERGUI or raises the existing
%      singleton*.
%
%      H = TESTERGUI returns the handle to a new TESTERGUI or the handle to
%      the existing singleton*.
%
%      TESTERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTERGUI.M with the given input arguments.
%
%      TESTERGUI('Property','Value',...) creates a new TESTERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testergui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testergui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testergui

% Last Modified by GUIDE v2.5 23-Apr-2017 11:16:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testergui_OpeningFcn, ...
                   'gui_OutputFcn',  @testergui_OutputFcn, ...
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


% --- Executes just before testergui is made visible.
function testergui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testergui (see VARARGIN)

% Choose default command line output for testergui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testergui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testergui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in imagefiles.
function imagefiles_Callback(hObject, eventdata, handles)
% hObject    handle to imagefiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns imagefiles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from imagefiles


% --- Executes during object creation, after setting all properties.
function imagefiles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imagefiles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
