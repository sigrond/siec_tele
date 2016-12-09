function varargout = siec_tele(varargin)
% SIEC_TELE MATLAB code for siec_tele.fig
%      SIEC_TELE, by itself, creates a new SIEC_TELE or raises the existing
%      singleton*.
%
%      H = SIEC_TELE returns the handle to a new SIEC_TELE or the handle to
%      the existing singleton*.
%
%      SIEC_TELE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIEC_TELE.M with the given input arguments.
%
%      SIEC_TELE('Property','Value',...) creates a new SIEC_TELE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before siec_tele_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to siec_tele_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help siec_tele

% Last Modified by GUIDE v2.5 09-Dec-2016 18:20:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @siec_tele_OpeningFcn, ...
                   'gui_OutputFcn',  @siec_tele_OutputFcn, ...
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



% --- Executes just before siec_tele is made visible.
function siec_tele_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to siec_tele (see VARARGIN)

% Choose default command line output for siec_tele
handles.output = hObject;
handles.A=zeros(10,10);
handles.B=ones(10,10);
handles.currentMatrix='A';
handles.G=digraph(handles.A);
handles.p=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes siec_tele wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = siec_tele_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_p.
function pushbutton_p_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.B=zeros(10,10);
set(handles.uitable1,'Data',handles.A);
handles.currentMatrix='A';
handles.G=digraph(handles.A);
handles.p=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_cen.
function pushbutton_cen_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.A=ones(12,12);
set(handles.uitable1,'Data',handles.B);
handles.currentMatrix='B';
handles.G=digraph(handles.B);
handles.p=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
guidata(hObject, handles);


% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

I=eventdata.Indices;
x=I(1);
y=I(2);
switch handles.currentMatrix
    case 'A'
        handles.A(x,y)=eventdata.NewData;
        set(handles.uitable1,'Data',handles.A);
        handles.G=digraph(handles.A);
        handles.p=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
    case 'B'
        handles.B(x,y)=eventdata.NewData;
        set(handles.uitable1,'Data',handles.B);
        handles.G=digraph(handles.B);
        handles.p=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton_analiza1.
function pushbutton_analiza1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analiza1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_analiza2.
function pushbutton_analiza2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analiza2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
