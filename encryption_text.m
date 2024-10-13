
global cipher_text FILE_TEXT inforamtion flag number_byte_text mask_TEXT
[file,path] = uigetfile({'*.txt', 'File Selector'});
inforamtion=fread(fopen(strcat(path,file)));
% fid = fopen('issam.txt');
% x=fread(fid);
FILE_TEXT=strcat(path,file);
%
%???? ??? ???? 
%
L_TEXT=length(inforamtion);
number_byte_text=0;
mask_TEXT=L_TEXT;
while (mask_TEXT>255)
    mask_TEXT=mask_TEXT-255;
    number_byte_text=number_byte_text+1;
end


%???????????????????????






x=inforamtion;
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

flag=1;

cipher_text=d1;
cipher_text=uint8(cipher_text);

clear ciphertext a d1 i  plaintext w x y s_box poly_mat inv_poly_mat inv_s_box s_box c z plaintext_hex d 



