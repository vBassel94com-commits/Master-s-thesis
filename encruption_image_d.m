
global rows colum FILE cipher_image I flag  cipher_image1 number_byte_image2 number_byte_image1 mask_image L_image
[file,path] = uigetfile({'*.jpg', 'File Selector'});
if file ==0
    return;
end
fid = fopen(strcat(path,file), 'r');
 a= fread(fid, [1 inf], '*uint8');
 [s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init;
 L_image=length(a);
 I=imread(strcat(path,file));
 [ rows colum ]=size(I);
number_byte_image1=0;
number_byte_image2=0;
mask_image=L_image;
while (mask_image>255)
    mask_image=mask_image-255;
    number_byte_image2=number_byte_image2+1;
    if(number_byte_image2==255)
        number_byte_image1=number_byte_image1+1;
        number_byte_image2=0;
    end
    
end
% disp(number_byte_image1)
% disp(number_byte_image2)
% disp(mask_image);



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


cipher_image1=d1;
cipher_image=reshape(d1,16,[]);
%  if R~=0
% d1(LENC+r:-1:LENC+1)=[];
%  end
% % 
 cipher_image1=uint8(cipher_image1);
%????? ?????? ?? 8 ?? 
cipher_image=uint8(cipher_image);
%  figure(1)
%   imshow(cipher_image)
%  figure(2)
%  
%   imshow(I)




clear  c ciphertext d  z plaintext_hex plaintext ciphertext i  w s_box poly_mat d1 R r count  LENC path file 
clear inv_poly_mat  inv_s_box  rows colum fid  flag x y



