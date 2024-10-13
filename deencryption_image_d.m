
 global receive_information plain_text re_L_image re_image cipher_image_receive


cipher_image_receive=receive_information;
c=receive_information;
c=double(c);
[s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init;
d=c(1:16);
ciphertext=d(1:16);
re_plaintext = inv_cipher (ciphertext, w, inv_s_box, inv_poly_mat, 1);
d2=re_plaintext;
LENC=length(c);

% R=mod(length(c),16);
% r=16-R;
% if R~=0
% 
% c(length(c)+1:length(c)+r)=0;
% end

parfor i=1:length(c)/16-1
a=1+(i*16);
b=16+(i*16);

d=c(a:b);

ciphertext=d(1:16);
re_plaintext = inv_cipher (ciphertext, w, inv_s_box, inv_poly_mat, 1);
d2 =[d2 re_plaintext];
end
% if R~=0
% d2(LENC+r:-1:LENC+1)=[];
% end
L=LENC-re_L_image;
d2([re_L_image+L:-1:re_L_image+1])=[];
re_image=d2;
cipher_image_receive=reshape(cipher_image_receive,16,[]);
re_image=uint8(re_image);
fid = fopen('OutputF1ile.jpg', 'w');
fwrite(fid, re_image);

re_image=imread('OutputF1ile.jpg');
