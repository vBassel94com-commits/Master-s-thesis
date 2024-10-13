global   number_byte_text_receive re_L_image mask_TEXT re_number_byte_image2 re_number_byte_image1 mask  re_mask_sound re_number_byte_sound1 re_number_byte_sound2
% receive_information=uint8(receive_information);
global re_L_sound receive_information c    FLAG L_TEXT re_number_byte_video1 re_number_byte_video2 re_mask_video re_L_video
if receive_information(1)== 255 
    FLAG=255;
%     length(receive_information)
    re_number_byte_image1=receive_information(2);
    re_number_byte_image2=receive_information(3);
     mask=receive_information(4);
%     mask_colum_receive=receive_information(5);
re_number_byte_image1=double(re_number_byte_image1);
re_number_byte_image2=double(re_number_byte_image2);
mask=double(mask);
    re_L_image=(re_number_byte_image1*65025)+(re_number_byte_image2*255)+mask;
%     re_colum=mask_colum_receive+(255*number_byte_colum_receive);
    receive_information([1 2 3 4])=[];
    
% length(receive_information)
    deencryption_image_d
     %receive
     %TEXTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
elseif receive_information(1)==1
FLAG=1;
    
    number_byte_text_receive=receive_information(2);
    mask_TEXT  =receive_information(3);
     L_TEXT=mask_TEXT+(255*number_byte_text_receive);
      receive_information([1,2,3])=[];
   
    
deencryption_text
 %receive
     %soundddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
elseif receive_information(1)==127
    FLAG=127;
    re_number_byte_sound1=receive_information(2);
    re_number_byte_sound2=receive_information(3);
     re_mask_sound=receive_information(4);
     re_number_byte_sound1=double(re_number_byte_sound1);
     re_number_byte_sound2=double(re_number_byte_sound2);
      re_mask_sound=double(re_mask_sound);
     
     re_L_sound=(re_number_byte_sound1*65025)+(re_number_byte_sound2*255)+re_mask_sound;
     
     receive_information([1 2 3 4])=[];
     deencryption_sound
     %receive
     %videoooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo
     elseif receive_information(1)==240
    FLAG=240;
    re_number_byte_video1=receive_information(2);
    re_number_byte_video2=receive_information(3);
     re_mask_video=receive_information(4);
     re_number_byte_video1=double(re_number_byte_video1);
     re_number_byte_video2=double(re_number_byte_video2);
      re_mask_video=double(re_mask_video);
     
     re_L_video=(re_number_byte_video1*65025)+(re_number_byte_video2*255)+re_mask_video;
     
     receive_information([1 2 3 4])=[];
     deencryption_video
     

end