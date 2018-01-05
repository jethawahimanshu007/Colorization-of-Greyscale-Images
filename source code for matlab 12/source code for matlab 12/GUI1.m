function varargout = GUI1(varargin)
% GUI1 M-file for GUI1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI1_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help GUI1

% Last Modified by GUIDE v2.5 06-Apr-2013 22:15:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI1_OutputFcn, ...
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


% --- Executes just before GUI1 is made visible.
function GUI1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI1 (see VARARGIN)

% Choose default command line output for GUI1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global im_original;
    global fname;
    [fname pname] = uigetfile('*.*','Choose source image');
    ims = imread(strcat(pname,fname));
    im_original=ims;
    %figure(1);imshow(ims);
    axes(handles.axes4);
    image (ims);
    axis off;
    [m n k] = size(ims);
    for i = 1:m
        for j = 1:n
            a(i,j,1)=uint8(ims(i,j,1));
            a(i,j,2)=uint8(ims(i,j,2));
            a(i,j,3)=uint8(ims(i,j,3));
        end
    end
    global vec_space;
    vec_space=divide_window_size(a,1,1,1);
    %vec_space
    %vec_space = divide_window_size(a,str2num(get(handles.edit1,'string')),str2num(get(handles.edit2,'string')),1);
    msgbox('Image reading into buffer completed. Please proceed.');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global imt;
    global fname1;
    [fname1 pname1] = uigetfile('*.*','Choose grayscale image');
    imt = imread(strcat(pname1,fname1));
    axes(handles.axes5);
    imshow (imt);
    colormap(gray);
    axis off;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    str=get(handles.popupmenu1,'String');
    val=get(handles.popupmenu1,'Value');
    global cb;
    global vec_space;
    str2=get(handles.popupmenu2,'String');
    val2=get(handles.popupmenu2,'Value');
    cb_size=str2num(str2{val2});
    cb_size
    %vec_space
    global algoName;
    global sizeName;
    sizeName=int2str(cb_size);
    switch str{val};
        case 'LBG' % User selects peaks.
           algoName='LBG';
           tic
           cb = lbg2(vec_space,cb_size,15);
           toc
        case 'KPE' % User selects membrane.
            algoName='KPE';
            tic
            cb=kpe(vec_space,cb_size);
            toc
        case 'KFCG' % User selects sinc.
            algoName='KFCG';
            tic
            cb=fcg(vec_space,uint8(log2(cb_size)));
            toc
    end
    msgbox('Vector Quantization completed.Please proceed.');

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    global cb;
    global imt;
    global im_original;
    global fname;
    global fname1;
    global algoName;
    global sizeName;
    colorized=colorize2(imt,cb,1,1);
    figure(4);imshow(colorized);
    
    %Uncoment line after this comment block for saving the images. First create 'Results' 
    %folder and get write permissions for that folder.
    
    %imwrite(colorized,strcat('Results\',fname1,fname,algoName,sizeName,'.jpg'),'jpg');
    %MSE = reshape(mean(mean((double(colorized) - double(im_original)).^2,2),1),[1,3]);
    %MSE
    %mean(MSE)
    
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end



% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end





