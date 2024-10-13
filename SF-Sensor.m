addpath subFunctions
addpath MATLAB
[file,path] = uigetfile({'*.txt', 'File Selector'});
if file ==0
    return;
end
fid = fopen(strcat(path,file), 'r');
Data= fread(fid, [1 inf], '*uint8');
Orignal= fread(fid, [1 inf], '*uint8');
global enc
[row,col]=size(Data);
[Data,padding]=Scalling(Data,8);
display(Data);

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
for i=1:size(Data_binary,1)
orignal=Data_binary(i,:);

[cipher]=SF_Encrypt(orignal,K1,K2,K3,K4,K5);

encrypt_msg(:,i)=Binary2Dec(cipher);
end
display(encrypt_msg);
encrypt_text=char(encrypt_msg);
display(encrypt_text);

%%

for i=1:8 
    for j=1:size(encrypt_msg,2)
        D(i,j)=sub_bytes (encrypt_msg(i,j), s_box);
    end
end
encryption_time(i)=toc
encrypt_msg=D;
Key_1=encrypt_msg;
D=[];
figure;

display(encrypt_msg);
encrypt_text=char(encrypt_msg);
display(encrypt_text);
title('Encrypted text');

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


% global data_text_AES data_text_RSA D
[file,path] = uigetfile({'*.txt', 'File Selector'});
if file ==0
    return;
end
fid = fopen(strcat(path,file), 'r');
Data= fread(fid, [1 inf], '*uint8');
Orignal= fread(fid, [1 inf], '*uint8');
global enc
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
tic 
for i=1:size(Data_binary,1)
orignal=Data_binary(i,:);

[cipher]=SF_Encrypt(orignal,K1,K2,K3,K4,K5);

encrypt_msg(:,i)=Binary2Dec(cipher);
end

%%

for i=1:8 
    for j=1:size(encrypt_msg,2)
        D(i,j)=sub_bytes (encrypt_msg(i,j), s_box);
    end
end
encryption_time(i)=toc
encrypt_msg=D;
D=[];


Key_2=encrypt_msg;
%decrypt_Text = 'hello';

decrypt_Text = 'Oak Street Weather Station	5/22/2019 00:00		98   89.2  98.6   98.3	99  99.5  99.8	100.3	100	99.2	99	98.5	5/22/2019 23:59	OakStreetWeatherStation201505221500';


display(decrypt_Text);


shanon=bitxor(Key_1(:),Key_2(:));
Data_binary3=convert2bin(shanon(:));
shanon_value=sum(Data_binary3);
shanon_value_percent=(shanon_value*100)/length(Data_binary3);
display(['shanon_value_percent=' num2str( shanon_value_percent ) '%' ])




% Decrypt a string according to Secure Force algorithm
% Assume that the encrypted text and the key are stored in variables encrypt_text and hex_key

% Convert the encrypted text to binary
encrypt_msg = uint8(encrypt_text);
Data_binary = convert2bin(encrypt_msg);

% Convert the key to binary
[bin_key] = Hex2Bin(hex_key);
II = bin_key(1:3);
II = double(II);
II = num2str(II);
II = bin2dec(II);

% Generate the subkeys for decryption
[K1,K2,K3,K4,K5] = SF_Key_Gen(bin_key);

% Generate the inverse S-box
[s_box, inv_s_box] = s_box_gen(1,II);

% Apply the inverse sub-bytes operation
for i = 1:8
    for j = 1:size(encrypt_msg,2)
        D(i,j) = sub_bytes(encrypt_msg(i,j), inv_s_box);
    end
end
encrypt_msg = D;
display(D);
ascii_char = char(D);
display(ascii_char);

D = [];
display(D);
% Apply the decryption rounds
decrypt_msg = [];
for i = 1:size(Data_binary,1)
    cipher = Data_binary(i,:);
    
    [plain] = SF_Decryption(cipher,K1,K2,K3,K4,K5);
    
    decrypt_msg(:,i) = Binary2Dec(plain);
end

% Convert the decrypted message to text
decrypt_text = char(decrypt_msg);


