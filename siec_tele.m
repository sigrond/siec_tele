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

% Last Modified by GUIDE v2.5 16-Dec-2016 09:42:56

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
handles.p=handles.A;
handles.kos=handles.A;
handles.kar=handles.A;
handles.cen=handles.A;
%handles.B=ones(10,10);
handles.currentMatrix='p';
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
handles.AMPLpath=load_AMPL_path();
handles.DatFileName='dataV2.dat';


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
handles.A=handles.p;
set(handles.uitable1,'Data',handles.A);
handles.currentMatrix='p';
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_cen.
function pushbutton_cen_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.A=ones(12,12);
handles.A=handles.cen;
set(handles.uitable1,'Data',handles.A);
handles.currentMatrix='cen';
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
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

handles.A(x,y)=eventdata.NewData;
set(handles.uitable1,'Data',handles.A);
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);

switch handles.currentMatrix
    case 'p'
        handles.p=handles.A;
    case 'kos'
        handles.kos=handles.A;
    case 'kar'
        handles.kar=handles.A;
    case 'cen'
        handles.cen=handles.A;
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton_analiza1.
function pushbutton_analiza1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analiza1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=strjoin(handles.AMPLpath{1});
saveData1_5(handles.p,'dataV15');
write_bat_for_AMPL( s, 'model.mod', 'dataV15.dat', 'runV15.run' );
system('a1.bat');
handles.x = load_AMPL_results15();
handles.A=handles.x;
handles.currentMatrix='x';
set(handles.uitable1,'Data',handles.A);
set(handles.pushbutton_x,'Enable','on');

g1=digraph(handles.p);
g2=digraph(handles.x);
%[sOut,tOut]=findedge(g1,g2.Edges.EndNodes);
%findedge jest zbugowane, nie znajduje wszystkich krawêdzi
[sOut,tOut]=myFindEdge(g1,g2.Edges.EndNodes(:,1),g2.Edges.EndNodes(:,2));
g3=g1;
g3=rmedge(g3,sOut,tOut);
g3=addedge(g3,g2.Edges);
%handles.G=digraph(handles.A);
handles.G=g3;
g4=g1;
g4.Edges.Weight=zeros(size(g4.Edges.Weight,1),1);
g4=rmedge(g4,sOut,tOut);
g4=addedge(g4,g2.Edges);
labels=cell(size(handles.G.Edges.Weight,1),1);
for i=1:size(handles.G.Edges.Weight,1)
    labels(i)={sprintf('%d/%d',g4.Edges.Weight(i),g1.Edges.Weight(i))};
end
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',labels);
highlight(handles.pl,g2.Edges.EndNodes(:,1),g2.Edges.EndNodes(:,2),'EdgeColor','red')
highlight(handles.pl,1);
highlight(handles.pl,1,'NodeColor','g');
highlight(handles.pl,size(handles.G.Nodes,1));
highlight(handles.pl,size(handles.G.Nodes,1),'NodeColor','r');
textLabel = sprintf('wynik analizy 1:\n³uki krytyczne:\n');
for i=1:size(handles.G.Edges.Weight,1)
    if g4.Edges.Weight(i)==g1.Edges.Weight(i)
        highlight(handles.pl,g1.Edges.EndNodes(i,1),g1.Edges.EndNodes(i,2),'EdgeColor','r','LineWidth',3);
        textLabel = sprintf('%s [%d %d]',textLabel,g1.Edges.EndNodes(i,1),g1.Edges.EndNodes(i,2));
    end
end



set(handles.text_wynik_analizy, 'String', textLabel);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_analiza2.
function pushbutton_analiza2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analiza2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s=strjoin(handles.AMPLpath{1});
saveData2(handles.p,handles.kos,handles.kar,handles.cen,'dataV20');
write_bat_for_AMPL( s, 'modelV2.mod', 'dataV20.dat', 'runV2.run' );
system('a1.bat');
[ handles.x, handles.d ] = load_AMPL_results();
handles.x=hideAMPLgarbage(handles.x);
handles.d=hideAMPLgarbage(handles.d);
handles.A=handles.x;
handles.currentMatrix='x';
set(handles.uitable1,'Data',handles.A);
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
textLabel = 'wynik analizy 2';
set(handles.text_wynik_analizy, 'String', textLabel);
set(handles.pushbutton_x,'Enable','on');
set(handles.pushbutton_d,'Enable','on');
guidata(hObject, handles);


% --------------------------------------------------------------------
function files_Callback(hObject, eventdata, handles)
% hObject    handle to files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --------------------------------------------------------------------
function save_to_AMPL_Callback(hObject, eventdata, handles)
% hObject    handle to save_to_AMPL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
save_to_AMPL_data(handles.p,'p');
save_to_AMPL_data(handles.kos,'kos');
save_to_AMPL_data(handles.kar,'kar');
save_to_AMPL_data(handles.cen,'cen');



% --- Executes on button press in pushbutton_kos.
function pushbutton_kos_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.A=handles.kos;
set(handles.uitable1,'Data',handles.A);
handles.currentMatrix='kos';
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
guidata(hObject, handles);

% --- Executes on button press in pushbutton_kar.
function pushbutton_kar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_kar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.A=handles.kar;
set(handles.uitable1,'Data',handles.A);
handles.currentMatrix='kar';
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
guidata(hObject, handles);

% --------------------------------------------------------------------
function load_from_AMPL_Callback(hObject, eventdata, handles)
% hObject    handle to load_from_AMPL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[handles.DatFileName,handles.DatPathName] = uigetfile('*.dat','Wybierz odpowiedni plik z danymi.');
[ handles.p, handles.kos, handles.kar, handles.cen ]=load_from_AMPL_data(fullfile(handles.DatPathName, handles.DatFileName));
switch handles.currentMatrix
    case 'p'
        handles.A=handles.p;
    case 'kos'
        handles.A=handles.kos;
    case 'kar'
        handles.A=handles.kar;
    case 'cen'
        handles.A=handles.cen;
end
set(handles.uitable1,'Data',handles.A);
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
guidata(hObject, handles);

% --------------------------------------------------------------------
function uipushtool_open_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_x.
function pushbutton_x_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.A=handles.x;
handles.currentMatrix='x';
set(handles.uitable1,'Data',handles.A);
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
guidata(hObject, handles);


% --- Executes on button press in pushbutton_d.
function pushbutton_d_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.A=handles.d;
handles.currentMatrix='d';
set(handles.uitable1,'Data',handles.A);
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
guidata(hObject, handles);


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in pushbutton_dodaj_usun.
function pushbutton_dodaj_usun_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dodaj_usun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=dialog1();
if val>0
	handles.p=[handles.p(:,1:val-1) zeros(size(handles.p,1),1) handles.p(:,val:end)];
    handles.p=[handles.p(1:val-1,:); zeros(1,size(handles.p,2)); handles.p(val:end,:)];
    handles.kos=[handles.kos(:,1:val-1) zeros(size(handles.kos,1),1) handles.kos(:,val:end)];
    handles.kos=[handles.kos(1:val-1,:); zeros(1,size(handles.kos,2)); handles.kos(val:end,:)];
    handles.kar=[handles.kar(:,1:val-1) zeros(size(handles.kar,1),1) handles.kar(:,val:end)];
    handles.kar=[handles.kar(1:val-1,:); zeros(1,size(handles.kar,2)); handles.kar(val:end,:)];
    handles.cen=[handles.cen(:,1:val-1) zeros(size(handles.cen,1),1) handles.cen(:,val:end)];
    handles.cen=[handles.cen(1:val-1,:); zeros(1,size(handles.cen,2)); handles.cen(val:end,:)];
elseif val<0
    val=-val;
    handles.p=[handles.p(:,1:val-1) handles.p(:,val+1:end)];
    handles.p=[handles.p(1:val-1,:); handles.p(val+1:end,:)];
    handles.kos=[handles.kos(:,1:val-1) handles.kos(:,val+1:end)];
    handles.kos=[handles.kos(1:val-1,:); handles.kos(val+1:end,:)];
    handles.kar=[handles.kar(:,1:val-1) handles.kar(:,val+1:end)];
    handles.kar=[handles.kar(1:val-1,:); handles.kar(val+1:end,:)];
    handles.cen=[handles.cen(:,1:val-1) handles.cen(:,val+1:end)];
    handles.cen=[handles.cen(1:val-1,:); handles.cen(val+1:end,:)];
end
switch handles.currentMatrix
    case 'p'
        handles.A=handles.p;
    case 'kos'
        handles.A=handles.kos;
    case 'kar'
        handles.A=handles.kar;
    case 'cen'
        handles.A=handles.cen;
end
set(handles.uitable1,'Data',handles.A);
handles.G=digraph(handles.A);
handles.pl=plot(handles.G,'Layout','force','EdgeLabel',handles.G.Edges.Weight);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
