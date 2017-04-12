function varargout = dbs_convertfluoro(varargin)
% DBS_CONVERTFLUORO MATLAB code for dbs_convertfluoro.fig
%      DBS_CONVERTFLUORO, by itself, creates a new DBS_CONVERTFLUORO or raises the existing
%      singleton*.
%
%      H = DBS_CONVERTFLUORO returns the handle to a new DBS_CONVERTFLUORO or the handle to
%      the existing singleton*.
%
%      DBS_CONVERTFLUORO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DBS_CONVERTFLUORO.M with the given input arguments.
%
%      DBS_CONVERTFLUORO('Property','Value',...) creates a new DBS_CONVERTFLUORO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dbs_convertfluoro_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dbs_convertfluoro_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dbs_convertfluoro

% Last Modified by GUIDE v2.5 04-Nov-2016 10:04:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dbs_convertfluoro_OpeningFcn, ...
                   'gui_OutputFcn',  @dbs_convertfluoro_OutputFcn, ...
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


% --- Executes just before dbs_convertfluoro is made visible.
function dbs_convertfluoro_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dbs_convertfluoro (see VARARGIN)

% Choose default command line output for dbs_convertfluoro
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dbs_convertfluoro wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dbs_convertfluoro_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in saveas.
function saveas_Callback(hObject, eventdata, handles)
% hObject    handle to saveas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in flip.
function flip_Callback(hObject, eventdata, handles)
% hObject    handle to flip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Done.
function Done_Callback(hObject, eventdata, handles)
% hObject    handle to Done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
