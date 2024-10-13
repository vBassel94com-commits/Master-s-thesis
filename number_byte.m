global mask_rows mask_colum number_byte_rows number_byte_colum 
mask_rows=rows;mask_colum=colum;
number_byte_rows=0;
number_byte_colum=0;
while (mask_rows>255)
    mask_rows=mask_rows-255;
    number_byte_rows=number_byte_rows+1;
end


 while (mask_colum>255)
    mask_colum=mask_colum-255;
    number_byte_colum=number_byte_colum+1;
 end   
