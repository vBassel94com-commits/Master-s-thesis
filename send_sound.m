global s cipher_sound L_sound number_byte_sound1 number_byte_sound2 mask_sound
fwrite(s,127,'uint8'); 
cipher_sound1=uint8(cipher_sound);
fwrite(s,number_byte_sound1,'uint8');
fwrite(s,number_byte_sound2,'uint8');
fwrite(s,mask_sound,'uint8');
% fwrite(s,mask_colum,'uint8');
% rows1=length(cipher_sound);
for   i=1:length(cipher_sound1)

fwrite(s, cipher_sound1(1,i),'uint8');

end