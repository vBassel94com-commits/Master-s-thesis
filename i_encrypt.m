function en = i_encrypt(in,n,e)


en=1;
en=uint8(mod((in)^e,n));

end