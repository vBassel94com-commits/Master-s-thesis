global s cipher_video  number_byte_video1 number_byte_video2 mask_video
fwrite(s,240,'uint8'); 
cipher_video1=uint8(cipher_video);
fwrite(s,number_byte_video1,'uint8');
fwrite(s,number_byte_video2,'uint8');
fwrite(s,mask_video,'uint8');
% fwrite(s,mask_colum,'uint8');
% rows1=length(cipher_sound);
for   i=1:length(cipher_video)

fwrite(s, cipher_video1(1,i),'uint8');

end