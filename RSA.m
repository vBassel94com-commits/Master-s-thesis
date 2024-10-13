clc
clear
inImg1 =(imread('www.gif'));

figure,imshow(inImg1)
inImg1=double(inImg1);

inImg=reshape(inImg1,1,[]);
 
L=length(inImg);

for i=1:L
   
    enImg(1,i) = mod(inImg(1,i)^7,33);
 
end

% for i=1:L
%    
%     dnImg(1,i) = mod(enImg(1,i)^743,143);
%  
% end

% E=floor((enImg./41196)*255);
% EnImg=reshape(E,1227,[]);
% % x=uint8(EnImg);
% % figure,imshow(x)
% 
% EnImg=uint8(EnImg);
% 
% figure,imshow(EnImg);
% 
% for i=1:L
%    
%     dnImg(1,i) = mod(E(1,i)^30323,41347);
%  
% end
% 
% 
% 
