global receive_information plain_text L_TEXT re_image

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
L=LENC-L_TEXT;
d2([L_TEXT+L:-1:L_TEXT+1])=[];
plain_text=d2;