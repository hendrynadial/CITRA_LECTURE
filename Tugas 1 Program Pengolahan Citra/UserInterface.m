function varargout = guidetemplate0(varargin)
% GUIDETEMPLATE0 M-file for guidetemplate0.fig
%      GUIDETEMPLATE0, by itself, creates a new GUIDETEMPLATE0 or raises the existing
%      singleton*.
%
%      H = GUIDETEMPLATE0 returns the handle to a new GUIDETEMPLATE0 or the handle to
%      the existing singleton*.
%
%      GUIDETEMPLATE0('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIDETEMPLATE0.M with the given input arguments.
%
%      GUIDETEMPLATE0('Property','Value',...) creates a new GUIDETEMPLATE0 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guidetemplate0_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guidetemplate0_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2006 The MathWorks, Inc.

% Edit the above text to modify the response to help guidetemplate0

% Last Modified by GUIDE v2.5 16-Mar-2015 08:25:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guidetemplate0_OpeningFcn, ...
                   'gui_OutputFcn',  @guidetemplate0_OutputFcn, ...
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


% --- Executes just before guidetemplate0 is made visible.
function guidetemplate0_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guidetemplate0 (see VARARGIN)

% Choose default command line output for guidetemplate0
handles.output = hObject;
set(handles.txt_path,'String','Browse image file');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guidetemplate0 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guidetemplate0_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in bt_grayscale.
function bt_grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to bt_grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image;
Image{2} = rgb2gray(Image{1}); 
axes(handles.view_image);
imshow(Image{2});
title('Convert to Grayscale Image');

% --- Executes on button press in bt_biner.
function bt_biner_Callback(hObject, eventdata, handles)
% hObject    handle to bt_biner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image;
Image{3} = im2bw(Image{1},graythresh(Image{1}));
axes(handles.view_image);
imshow(Image{3});
title('Convert to binary Image');

% --- Executes on button press in bt_brightness.
function bt_brightness_Callback(hObject, eventdata, handles)
% hObject    handle to bt_brightness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image;
brightnessImage = imadjust(Image{1}, [0 0.5], [0 1]);
axes(handles.view_image);
imshow(brightnessImage);
title('Adjust brightness');

% --- Executes on button press in bt_contrast.
function bt_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to bt_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image;
contrastImage = imadjust(Image{1},[0.3 0.7],[]);
axes(handles.view_image);
imshow(contrastImage);
title('Adjust Contrast');

% --- Executes on button press in bt_inverse.
function bt_inverse_Callback(hObject, eventdata, handles)
% hObject    handle to bt_inverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image;
Image{4} = im2bw(Image{1},graythresh(Image{1}));
Image{4} = ~Image{4};
Image{4} = 1-Image{4};
Image{4} = (Image{4} == 0);

axes(handles.view_image);
imshow(Image{4});
title('Convert to Inverse Image');

% --- Executes on button press in bt_browse.
function bt_browse_Callback(hObject, eventdata, handles)
% hObject    handle to bt_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image;
[FileName,PathName] = uigetfile({'*.jpg;*.JPG','Select the jpg-filed'});
if ~isequal(FileName,0)
    Image{1} = imread(fullfile(PathName,FileName));
    set(handles.txt_path,'String',fullfile(PathName,FileName));
    checkImage = rgb2gray( Image{1});  
    [height width] = size(checkImage);
    if (height<=960 && height>=320) && (width<=1280 && width>=480)
        axes(handles.view_image);
        imshow(Image{1});
  
        guidata(hObject, handles);
        set(handles.bt_grayscale,'Enable','on');
        set(handles.bt_original,'Enable','on');
        set(handles.bt_contrast,'Enable','on');
        set(handles.bt_brightness,'Enable','on');
        set(handles.bt_inverse,'Enable','on');
        set(handles.bt_biner,'Enable','on');
        set(handles.bt_mbit,'Enable','on');
        set(handles.bt_clear,'Enable','on');
       
    else
        errmsg = 'Image size is wrong!\n It is should be between 480x320 to 1280x960.';
        errordlg(sprintf(errmsg),'Invalid Image Size');
    end
    
else
    return;
end


% --- Executes on button press in bt_original.
function bt_original_Callback(hObject, eventdata, handles)
% hObject    handle to bt_original (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image; 
axes(handles.view_image);
imshow(Image{1});
title('Original Image');


% --- Executes on button press in bt_exit.
function bt_exit_Callback(hObject, eventdata, handles)
% hObject    handle to bt_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;


% --- Executes on button press in bt_clear.
function bt_clear_Callback(hObject, eventdata, handles)
% hObject    handle to bt_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);
set(handles.bt_grayscale,'Enable','off');
set(handles.bt_original,'Enable','off');
set(handles.bt_contrast,'Enable','off');
set(handles.bt_brightness,'Enable','off');
set(handles.bt_inverse,'Enable','off');
set(handles.bt_biner,'Enable','off');
set(handles.bt_clear,'Enable','off');
set(handles.bt_mbit,'Enable','off');
set(handles.txt_path,'String','Browse image file');

axes(handles.view_image);
imshow(1);


% --- Executes on button press in bt_about.
function bt_about_Callback(hObject, eventdata, handles)
% hObject    handle to bt_about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
about


% --- Executes on button press in bt_mbit.
function bt_mbit_Callback(hObject, eventdata, handles)
% hObject    handle to bt_mbit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Image
Image{5} = rgb2gray(Image{1}); 
Image{5} = im2uint16(Image{5});
axes(handles.view_image);
imshow(Image{5});
title('Convert to 16 Bit Image');
