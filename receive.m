
global s receive_information
     pause(3)
    m=s.BytesAvailable;
    while s.BytesAvailable>0
       
        if m==s.BytesAvailable
           
        
            receive_information=fread(s);
        end
        
    end
    
    



