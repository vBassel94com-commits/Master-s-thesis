clc
clear all
close all
addpath subFunctions
addpath MATLAB
Images_Path='images\';
fname={'Football'};
ext='.jpg';
fid=1; % file ID 1 for lena
IS =256; % Image size
Data=imread(strcat(Images_Path,fname{fid},ext));
if (size(Data,3)==3)
Data=rgb2gray(Data);
end
Data=imresize(Data,[IS IS]); % Image Size
figure
imshow(Data)
title('Orginal image')
[row,col]=size(Data);
[Data,padding]=Scalling(Data,8);
Data_binary=convert2bin(Data);
hex_key = 'DABC123456789AFE';
[bin_key] = Hex2Bin( hex_key );
II=bin_key(1:3);
II=double(II);
II=num2str(II);
II=bin2dec(II);
[K1,K2,K3,K4,K5]=SF_Key_Gen(bin_key);
orignal_msg=[];
encrypt_msg=[];
decrypt_msg=[];
[s_box, inv_s_box] = s_box_gen (1,II);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Encryption
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parfor i=1:size(Data_binary,1)
orignal=Data_binary(i,:);

[cipher]=SF_Encrypt(orignal,K1,K2,K3,K4,K5);

encrypt_msg(:,i)=Binary2Dec(cipher);
end

%%

for i=1:8 
    for j=1:8192
        D(i,j)=sub_bytes (encrypt_msg(i,j), s_box);
    end
end

encrypt_msg=D;
D=[];
Encrypted=uint8(reshape(encrypt_msg,[row,col]));
figure

imshow(Encrypted)
title('Encrypted image');


key1=Encrypted(:);







%% ---------------------------------------------
addpath subFunctions
addpath MATLAB
Images_Path='images\';
fname={'Football'};
ext='.jpg';
fid=1; % file ID 1 for lena
IS =256; % Image size
Data=imread(strcat(Images_Path,fname{fid},ext));
if (size(Data,3)==3)
Data=rgb2gray(Data);
end
Data=imresize(Data,[IS IS]); % Image Size
figure
imshow(Data)
title('Orginal image')
[row,col]=size(Data);
[Data,padding]=Scalling(Data,8);
Data_binary=convert2bin(Data);
hex_key = 'EABC123456789AFE';
[bin_key] = Hex2Bin( hex_key );
II=bin_key(1:3);
II=double(II);
II=num2str(II);
II=bin2dec(II);
[K1,K2,K3,K4,K5]=SF_Key_Gen(bin_key);
orignal_msg=[];
encrypt_msg=[];
decrypt_msg=[];
[s_box, inv_s_box] = s_box_gen (1,II);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Encryption
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
parfor i=1:size(Data_binary,1)
orignal=Data_binary(i,:);

[cipher]=SF_Encrypt(orignal,K1,K2,K3,K4,K5);

encrypt_msg(:,i)=Binary2Dec(cipher);
end

%%

for i=1:8 
    for j=1:8192
        D(i,j)=sub_bytes (encrypt_msg(i,j), s_box);
    end
end

encrypt_msg=D;
D=[];
Encrypted=uint8(reshape(encrypt_msg,[row,col]));
figure

imshow(Encrypted)
title('Encrypted image');

key2=Encrypted(:);

shanon=bitxor(key1(:),key2(:));
Data_binary3=convert2bin(shanon(:));
shanon_value=sum(Data_binary3);
shanon_value_percent=(shanon_value*100)/length(Data_binary3);
display(['shanon_value_percent=' num2str( shanon_value_percent ) '%' ])

