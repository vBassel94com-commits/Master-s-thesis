global s cipher_image1 number_byte_rows mask_rows number_byte_colum mask_colum number_byte_image1 number_byte_image2 mask_image L_image
fwrite(s,255,'uint8'); 

fwrite(s,number_byte_image1,'uint8');
fwrite(s,number_byte_image2,'uint8');
fwrite(s,mask_image,'uint8');
% fwrite(s,mask_colum,'uint8');
% rows1=length(cipher_image1);
for   i=1:length(cipher_image1)

fwrite(s, cipher_image1(1,i),'uint8');

end