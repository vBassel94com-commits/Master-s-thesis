global file cipher_sound L_sound number_byte_sound1 number_byte_sound2 mask_sound FILE path

[file,path] = uigetfile({'*.mp3', 'File Selector'});
if file ==0
    return;
end
fid = fopen(strcat(path,file), 'r');
mp3_content = fread(fid, [1 inf], '*uint8');
 fclose(fid); 
FILE=strcat(path,file);

L_sound=length(mp3_content);
 number_byte_sound1=0;
number_byte_sound2=0;
mask_sound=L_sound;
while (mask_sound>255)
    mask_sound=mask_sound-255;
    number_byte_sound2=number_byte_sound2+1;
    if(number_byte_sound2==255)
        number_byte_sound1=number_byte_sound1+1;
        number_byte_sound2=0;
    end
    
end

a=mp3_content;


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

cipher_sound=d1;
