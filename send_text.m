global s
fwrite(s,1,'uint8');
for i=1:length(cipher_text)
fwrite(s,cipher_text(i),'uint8');
end