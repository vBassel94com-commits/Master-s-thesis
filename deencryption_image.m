%****************************************************************
%*******       ???????? ?? ??????? ??????           *************
%*******                                            *************
%****************************************************************
%???? ???? ???????? ??? ???? ???? 
% ??? ???????? 
%x3 ?????? ????????? ??????? ??????
global receive_information re_image  re_rows re_colum cipher_image_receive L_image L lenc c
% uint32(c);
% uint32(re_colum);
% uint32(re_rows);
lenc=re_colum*re_rows;
c=receive_information;
%x3=reshape(re_image_cipher,[],1);
 receive_information=double(receive_information);
 c=double(c);
L_image=length(c);
L=L_image-lenc;
receive_information([L_image:-1:(L_image-L+1)])=[];
receive_information=uint8(receive_information);
cipher_image_receive=reshape(receive_information,re_rows,re_colum);

%double ???? ??????  ??? ??? 
% int8 ????? ??? ?????? ???? ???? ?????? ?? ??? 

[s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init;
d=c(1:16);
ciphertext=d(1:16);
re_plaintext = inv_cipher (ciphertext, w, inv_s_box, inv_poly_mat, 1);
d2=re_plaintext;

% LENC=length(c);
% 
% R=mod(length(c),16);
% r=16-R;
% if R~=0

% c(length(c)+1:length(c)+r)={'0'};
% end
parfor i=1:length(c)/16-1
a=1+(i*16);
b=16+(i*16);

d=c(a:b);
ciphertext=d(1:16);
re_plaintext = inv_cipher (ciphertext, w, inv_s_box, inv_poly_mat, 1);
d2=[d2 re_plaintext];
end
d2([L_image:-1:L_image-L+1])=[];
% if R~=0
% d1(LENC+r:-1:LENC+1)=[];
% end
re_image=reshape(d2,re_rows,re_colum);
re_image=uint8(re_image);
% imshow(re_image)
clear c d d2 ciphertext re_plaintext i 