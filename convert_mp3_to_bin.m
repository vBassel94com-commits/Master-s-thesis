
%*******************************************************************
%show video
[chosenfile, chosenpath] = uigetfile('*.mp4', 'Select a video');
  if ~ischar(chosenfile)
    return;   %user canceled dialog
  end
  filename = fullfile(chosenpath, chosenfile);
%   set(handles.edit1, filename);
% filename = get(handles.edit1, filename);
  if ~exist(filename, 'file')
    warndlg( 'Text in edit box is not the name of a file');
    return
  end
  try
    obj = VideoReader(filename);
  catch
    warndlg( 'File named in edit box does not appear to be a usable movie file');
    return
  end
 
 
fid = fopen(filename, 'r');
mp4_content = fread(fid, [1 inf], '*uint8');
 fclose(fid); 
FILE=strcat(path,file);

L_video=length(mp4_content);
 number_byte_video1=0;
number_byte_video2=0;
mask_video=L_video;
while (mask_video>255)
    mask_video=mask_video-255;
    number_byte_video2=number_byte_video2+1;
    if(number_byte_video2==255)
        number_byte_video1=number_byte_video1+1;
        number_byte_video2=0;
    end
    
end

a=mp4_content;


x=a;
y=x';
a= y;
 [s_box, inv_s_box,w, poly_mat,inv_poly_mat] = aes_init;
c=dec2hex(a);
c=num2cell(c,2);

c=c';
d=c(1:16);
z=d(1:16);
plaintext_hex = z;
plaintext = hex2dec (plaintext_hex);
ciphertext = cipher (plaintext, w, s_box, poly_mat, 1);
d1=ciphertext;
LENC=length(c);

R=mod(length(c),16);
r=16-R;
if R~=0

c(length(c)+1:length(c)+r)={'0'};
end

parfor i=1:(length(c)/16-1)
%[s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init;
a=1+(i*16);
b=16+(i*16);

d=c(a:b);
z=d(1:16);
plaintext_hex = z;
plaintext = hex2dec (plaintext_hex);
ciphertext = cipher (plaintext, w, s_box, poly_mat, 1);
d1=[d1 ciphertext];
end

cipher_video=d1;
