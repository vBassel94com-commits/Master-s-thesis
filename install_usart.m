%INIAL USART
global Name_port
global s
s=serial(Name_port,'BaudRate',9600);
set(s,'OutputBufferSize',10000000);
set(s,'InputBufferSize',10000000);
%  s.BytesAvailableFcnMode = 'byte';
%  s.BytesAvailableFcnCount = 1;
%  s.BytesAvailableFcn = @newdata;
fopen(s);
set(handles.text4,'BackgroundColor','g')
