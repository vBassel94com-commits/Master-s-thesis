%% Mu Transmitter
clear all
clc
Mu=8;
nbit=8; 
max_value=5;
min_value=-5;
delta=(max_value-min_value)/(2^nbit);
partition = [min_value+delta:delta:max_value-delta];
partition_out = compand(partition,Mu,max_value,'mu/expander');
nTs=0:0.04:1;
samples=1*sin(2*pi*1*nTs);%[1.2 -0.2 -0.5 0.4 0.89 1.3];%
for i=1:length(samples)
index(i) = quantiz(samples(i),partition_out);
end
b = dec2bin(index,nbit);
b_new=reshape(b',1,[]);
for i=1:length(b_new)
    f(i) = str2num(b_new(i));
end
%% Mu Receiver
 
received_data=f;
data=[];
for i=1:nbit:length(received_data)
lev=received_data(:,i:i+nbit-1);
data=[data;lev];
end
str=[];
for i=1:length(data)
    str=sprintf('%d',data(i,:));
    rindex(i)=bin2dec(str);
end
reconstruction_levels=[min_value+(delta/2):delta:max_value-(delta/2)];
reconstruction_levels_out = compand(reconstruction_levels,Mu,max_value,'mu/expander');
 
recoverd_samples=reconstruction_levels_out(rindex+1);
figure(1)
subplot(121),plot(samples),title('Original signal');
subplot(122),stem(samples),title('Original Samples');
figure(2)
stem(received_data),axis([0 length(received_data) -0.5 1.5]);title('PCM signal');
figure(3)
subplot(121),stem(recoverd_samples),title('Recovered samples');
subplot(122),plot(recoverd_samples),title('Recovered Signal');
 
mse_of_Mu_quantization=sum((samples-recoverd_samples).^2)/length(samples)
 
p=1;
display_value=[];
d0=[];
d1=[];
for i=1:length(data)
    switch_value=int2str(data(i,2:4)); 
  switch switch_value
   case '1  1  1'  
display_value(i)='A';
      d0(i)=p/2;
      d1(i)=p;
   case '1  1  0'
display_value(i)='B';
      d0(i)=p/4;
      d1(i)=p/2;
   case '1  0  1'
display_value(i)='C';  
      d0(i)=p/8;
      d1(i)=p/4;
   case '1  0  0'
display_value(i)='D';
      d0(i)=p/16;
      d1(i)=p/8;
   case '0  1  1'
display_value(i)='E';
      d0(i)=p/32;
      d1(i)=p/16;
   case '0  1  0'
display_value(i)='F';
      d0(i)=p/64;
      d1(i)=p/32;
   case '0  0  1'
display_value(i)='G';
      d0(i)=p/128;
      d1(i)=p/64;
   case '0  0  0'
display_value(i)='H';      
      d0(i)=0;
      d1(i)=p/128;
   otherwise
display_value(i)='Error';
  end
end
segment = char(display_value');
mn=d0';
mx=d1';
codeword=b;
