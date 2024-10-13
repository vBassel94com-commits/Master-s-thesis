addpath subFunctions
addpath MATLAB
[file,path] = uigetfile({'*.txt', 'File Selector'});
if file ==0
    return;
end
fid = fopen(strcat(path,file), 'r');
Data= fread(fid, [1 inf], '*uint8');
Orignal= fread(fid, [1 inf], '*uint8');

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
parfor    i=1:size(Data_binary,1)
orignal=Data_binary(i,:);

[cipher]=SF_Encrypt(orignal,K1,K2,K3,K4,K5);

encrypt_msg(:,i)=Binary2Dec(cipher);
end

%%

for i=1:8 
    for j=1:length(encrypt_msg)
        D(i,j)=sub_bytes (encrypt_msg(i,j), s_box);
    end
end
encryption_time(i)=toc
encrypt_msg=D;
D=[];
figure

display(encrypt_msg)
title('Encrypted image');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% End

%9 Correlation
figure
subplot(1,2,1)
scatter(Orignal(1:end-1),Orignal(2:end),'.')
axis([0 255 0 255])
subplot(1,2,2)
scatter(encrypt_msg(1:end-1),encrypt_msg(2:end),'.')
axis([0 255 0 255])

%%
display(sprintf('Total encryption time: %f',sum(encryption_time)))


display('correlation coefficient of encrypted data')
corrcoef(double(encrypt_msg(1:end-1)),double(encrypt_msg(2:end)))
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
%% Shanon
load key_1 
load key_2
shanon=bitxor(key1(:),key2(:));
Data_binary3=convert2bin(shanon(:));
shanon_value=sum(Data_binary3);
shanon_value_percent=(shanon_value*100)/length(Data_binary3);
display(['shanon_value_percent=' num2str( shanon_value_percent ) '%' ])

