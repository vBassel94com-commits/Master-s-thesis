clc
clear all
close all
addpath subFunctions
addpath MATLAB
Images_Path='images\';
fname={'Lena'};
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
tic 
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
encryption_time(i)=toc
encrypt_msg=D;
D=[];
Encrypted=uint8(reshape(encrypt_msg,[row,col]));
figure

imshow(Encrypted)
title('Encrypted image');
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Decryption
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=encrypt_msg';

for i=1:8192 
    for j=1:8
        D(i,j)=sub_bytes (x(i,j), inv_s_box);
    end
end
 x=D;
% bb=x;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% Receive
z=reshape(x,8192,8);
x=z;

cipher_data=[];
for j=1:8192
 y=convert2bin(x(j,:));
q=[];
  for i=1:8
   q=[q y(i,:)];
  end
  cipher_data=[cipher_data;q];
end
parfor i=1:size(x,1)
cipher=cipher_data(i,:);
[plaintext]=SF_Decryption(cipher,K1,K2,K3,K4,K5);
decrypt_msg(:,i)=Binary2Dec(plaintext);
cipher_data(i,:)=double(plaintext);
end
Orignal=uint8(reshape(decrypt_msg,[row,col]));
figure

imshow(Orignal)
title('Decrypted');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% End
figure
subplot(2,1,1)
imhist(Orignal);
subplot(2,1,2)
imhist(Encrypted);
% 
% % % 14 Image Entropy
Y=(imhist(Encrypted)+0.00001)/(row*col);%(length(Data)-padding);
Y=-sum(Y.*log2(Y));
X=(imhist(Orignal)+0.00001)/(row*col);%(length(Data)-padding);
X=-sum(X.*log2(X));
Re=[X Y]
% % 
%9 Correlation
figure
subplot(1,2,1)
scatter(Orignal(1:end-1),Orignal(2:end),'.')
axis([0 255 0 255])
subplot(1,2,2)
scatter(Encrypted(1:end-1),Encrypted(2:end),'.')
axis([0 255 0 255])
% 
% % 1 NPCR(%)???? ???? ???????? ?? ??????
NPCR=sum(sum(Encrypted~=Orignal))*100/(row*col)
% 2 UACI(%) 
UACI=sum(sum(abs(Encrypted-Orignal)))*100/(row*col*255)
%%
display(sprintf('Total encryption time: %f',sum(encryption_time)))

display('correlation coefficient of original image')
corrcoef(double(Orignal(1:end-1)),double(Orignal(2:end)))
display('correlation coefficient of encrypted image')
corrcoef(double(Encrypted(1:end-1)),double(Encrypted(2:end)))
%% Balance
num=0;
Data_binary=convert2bin(encrypt_msg(:));
for i=1:length(Data_binary)
    if (Data_binary(i)==1)
        num=num+1;
    end
end
num_ones=num;
num_zeros=length(Data_binary)-num;
balance=(num_ones*100)/length(Data_binary);
display(['balance=' num2str( balance ) '%' ])
%% Shanon Avalance
load key_1 
load key_2
shanon=bitxor(key1(:),key2(:));
Data_binary3=convert2bin(shanon(:));
shanon_value=sum(Data_binary3);
shanon_value_percent=(shanon_value*100)/length(Data_binary3);
display(['shanon_value_percent=' num2str( shanon_value_percent ) '%' ])

