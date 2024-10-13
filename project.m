function varargout = project(varargin)
% PROJECT MATLAB code for project.fig
%      PROJECT, by itself, creates a new PROJECT or raises the existing
%      singleton*.
%
%      H = PROJECT returns the handle to a new PROJECT or the handle to
%      the existing singleton*.
%
%      PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJECT.M with the given input arguments.
%
%      PROJECT('Property','Value',...) creates a new PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help project

% Last Modified by GUIDE v2.5 02-Mar-2019 19:47:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @project_OpeningFcn, ...
                   'gui_OutputFcn',  @project_OutputFcn, ...
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

% --- Executes just before project is made visible.
function project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to project (see VARARGIN)

% Choose default command line output for project
        handles.output = hObject;
                        set(handles.listbox7,'visible','off')
                        set(handles.listbox9,'visible','off')
                        set(handles.pushbutton23,'visible','off');
                        set(handles.togglebutton2,'visible','off');
                        set(handles.togglebutton3,'visible','off');
                        set(handles.togglebutton4,'visible','off');
                        set(handles.togglebutton5,'visible','off');
                        set(handles.pushbutton28,'Visible','off');

        %  poolobj = parpool(2);
        % Update handles structure
        guidata(hObject, handles);

% UIWAIT makes project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in B_search_port.
function B_search_port_Callback(hObject, eventdata, handles)
% hObject    handle to B_search_port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


delete(instrfind);
 
    global F F1
        F1=0;

        Number_port=seriallist;
        if Number_port~=''
        set(handles.popupmenu_com,'string',Number_port)
        F=1;
        else
         set(handles.popupmenu_com,'string','NO PORT')
         F=0;
        end

    guidata(hObject, handles);

% --- Executes on selection change in popupmenu_com.
function popupmenu_com_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_com contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_com



contents = cellstr(get(hObject,'String'));
global Name_port s 
Name_port=contents{get(hObject,'Value')};
disp(Name_port)

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu_com_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in B_connect.
function B_connect_Callback(hObject, eventdata, handles)
% hObject    handle to B_connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global  F s F1
 if F~=0 && F1==0
   F1=1;  
install_usart
 else
      f = msgbox(' NO PORT  ', 'Error','error');  
 end
 
guidata(hObject, handles);



% --- Executes on button press in B_image.
function B_image_Callback(hObject, eventdata, handles)
% hObject    handle to B_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton23,'visible','off');
set(handles.togglebutton2,'visible','off');
set(handles.togglebutton3,'visible','off');
set(handles.togglebutton4,'visible','off');
set(handles.togglebutton5,'visible','off');
set(handles.pushbutton28,'Visible','off');
  
global F
if F~=0
set(handles.text5,'Visible','on')
set(handles.text5,'String','Encryption image now ... ')
encruption_image_d
% encryption_image
global rows colum FILE cipher_image I cipher_image1  number_byte_image2 number_byte_image1 mask_image L_image
% number_byte

global mask_rows mask_colum number_byte_rows number_byte_colum s
set(handles.edit1,'string',FILE);
axes(handles.axes4)
imshow(cipher_image)
axes(handles.axes5)
imshow(I)
% set(handles.axes4,'visible','on')
% set(handles.axes5,'visible','on')
set(handles.text5,'String','Sending image now ... ')
pause(1)
send_image
set(handles.text5,'visible','off')
else
   f = msgbox(' NO PORT  ', 'Error','error'); 
end


guidata(hObject, handles);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

guidata(hObject, handles);



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global Name_port number_byte_rows flag
% global cipher_text FILE_TEXT inforamtion 
% global rows colum FILE cipher_image I mask_rows mask_colum number_byte_colum s
% varable_install
% --- Executes on selection change in listbox2.
set(handles.pushbutton23,'visible','off');
set(handles.togglebutton2,'visible','off');
set(handles.togglebutton3,'visible','off');
set(handles.togglebutton4,'visible','off');
set(handles.togglebutton5,'visible','off');
set(handles.pushbutton28,'Visible','off');

set(handles.text5,'Visible','on')
set(handles.text5,'String','receiving data now ... ')
 global s receive_information cipher_image_receive re_image FLAG plain_text player  
receive
   
    re_data
    
    if FLAG==255
        
    axes(handles.axes4)
imshow(cipher_image_receive)
axes(handles.axes5)
imshow(re_image)
    elseif FLAG==1
set(handles.listbox9,'string',char (receive_information)');
set(handles.listbox7,'string',char (plain_text));
set(handles.listbox7,'visible','on')
set(handles.listbox9,'visible','on')
    elseif FLAG==127
       axes(handles.axes5)
        imshow('song.png')
         axes(handles.axes4)
          imshow('song.png') 
          set(handles.pushbutton28,'Visible','off');
           
          set(handles.pushbutton23,'Visible','on');
           set(handles.togglebutton2,'visible','on');
              set(handles.togglebutton3,'visible','on');
                set(handles.togglebutton4,'visible','on');
                  set(handles.togglebutton5,'visible','on');
    
              [y,Fs] = audioread('test.mp3');
              player = audioplayer(y, Fs);

     elseif FLAG==240
         
         axes(handles.axes4)
          imshow('AES_IMAGE.jpg')
         axes(handles.axes5)
          imshow('video.png')
              set(handles.pushbutton23,'visible','off');
              set(handles.togglebutton2,'visible','off');
              set(handles.togglebutton3,'visible','off');
              set(handles.togglebutton4,'visible','off');
              set(handles.togglebutton5,'visible','off');
              set(handles.pushbutton28,'Visible','on');
            
    end
  set(handles.text5,'Visible','off')  
    
%     disp(receive_information)
guidata(hObject, handles);
% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global F
if   F~=0
set(handles.text5,'Visible','on')
set(handles.text5,'String','Encryption text now ... ')

encryption_text 
global cipher_text FILE_TEXT inforamtion flag s L_TEXT mask_TEXT number_byte_text_receive number_byte_text
set(handles.edit2,'string',FILE_TEXT);
set(handles.listbox9,'string',char (cipher_text));
set(handles.listbox7,'string',char (inforamtion)');
set(handles.listbox7,'visible','on')
set(handles.listbox9,'visible','on')

set(handles.text5,'String','Sending text now ... ')
fwrite(s,1,'uint8');
fwrite(s,number_byte_text,'uint8');
fwrite(s,mask_TEXT,'uint8');
for i=1:length(cipher_text)
fwrite(s,cipher_text(1,i),'uint8');
end
set(handles.text5,'visible','off')
else
     f = msgbox(' NO PORT  ', 'Error','error'); 
end

guidata(hObject, handles);


% --- Executes on selection change in listbox7.
function listbox7_Callback(hObject, eventdata, handles)
% hObject    handle to listbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox7

guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function listbox7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);


% --- Executes on selection change in listbox9.
function listbox9_Callback(hObject, eventdata, handles)
% hObject    handle to listbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox9

guidata(hObject, handles);
% --- Executes during object creation, after setting all properties.
function listbox9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global s F
close_port
set(handles.text4,'BackgroundColor','r')
F=0;
guidata(hObject, handles);





% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
global re_image
global Filename Pathname
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, foldername] = uiputfile({'*.png';'*.jpg';'*.*'}, 'Save as');
complete_name = fullfile(foldername, filename);
imwrite(re_image, complete_name);
guidata(hObject, handles);


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global plain_text
[filename, foldername] = uiputfile({'*.txt'}, 'Save as');
complete_name = fullfile(foldername, filename);
fid=fopen(complete_name,'wb');
fwrite(fid,char(plain_text),'char');
fclose(fid);


% --- Executes on button press in pushbutton19.

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player FILE file y
% ax = handles.axes5;
global cipher_sound


global F
if   F~=0
set(handles.text5,'Visible','on')
set(handles.text5,'String','Encryption sound now ... ')

 encryption_soud_d
 
        axes(handles.axes5)
         imshow('song.png')
          axes(handles.axes4)
             imshow('song.png')
                     set(handles.pushbutton28,'Visible','off');
          
                     set(handles.pushbutton23,'Visible','on');
                     set(handles.togglebutton2,'visible','on');
                     set(handles.togglebutton3,'visible','on');
                     set(handles.togglebutton4,'visible','on');
                     set(handles.togglebutton5,'visible','on');
                 [y,Fs] = audioread(file);
              player = audioplayer(y, Fs);
            set(handles.edit8,'string',FILE);
          set(handles.text5,'String','Sending sound now ... ')
        pause(1)
      send_sound
     set(handles.text5,'visible','off')


else
   f = msgbox(' NO PORT  ', 'Error','error'); 
end

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global F filename
if   F~=0
set(handles.text5,'Visible','on')
set(handles.text5,'String','Encryption video now ... ')

 encryption_video
 
        axes(handles.axes5)
          imshow('AES_IMAGE.jpg')
         axes(handles.axes4)
          imshow('video.png')
              set(handles.pushbutton23,'visible','off');
              set(handles.togglebutton2,'visible','off');
              set(handles.togglebutton3,'visible','off');
              set(handles.togglebutton4,'visible','off');
              set(handles.togglebutton5,'visible','off');
              set(handles.pushbutton28,'Visible','on');
              
            set(handles.edit7,'string',filename);
          set(handles.text5,'String','Sending video now ... ')
        pause(1)
      sendvideo
     set(handles.text5,'visible','off')


else
   f = msgbox(' NO PORT  ', 'Error','error'); 
end
    

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
play(player);
% Hint: get(hObject,'Value') returns toggle state of pushbutton23


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
pause(player);
% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
resume(player);
% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player
stop(player);
% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on scroll wheel click while the figure is in focus.
function figure1_WindowScrollWheelFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	VerticalScrollCount: signed integer indicating direction and number of clicks
%	VerticalScrollAmount: number of lines scrolled for each click
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cipher_sound
sound(cipher_sound);
% Hint: get(hObject,'Value') returns toggle state of togglebutton5



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
         axes(handles.axes4)
          imshow('AES_IMAGE.jpg')
         axes(handles.axes5)
          imshow('video.png')
              set(handles.pushbutton23,'visible','off');
              set(handles.togglebutton2,'visible','off');
              set(handles.togglebutton3,'visible','off');
              set(handles.togglebutton4,'visible','off');
              set(handles.togglebutton5,'visible','off');
              set(handles.pushbutton28,'Visible','on');


function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename obj
try
    obj = VideoReader(filename);
  catch
    warndlg( 'File named in edit box does not appear to be a usable movie file');
    return
  end
 
    ax = handles.axes5;
     while hasFrame(obj)
        vidFrame = readFrame(obj);
        image(vidFrame, 'Parent', ax);
        set(ax, 'Visible', 'off');
        pause(1/obj.FrameRate);
    end
    clear obj


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
