clear
tic
w=0.1*rand(2,2);
wb=rand(1,2);
gama=0.1;
b=0.2;
p=[0.5 1.5;1 1;-0.5 -0.5;-1 -1;0.2 -0.2;0.3 -0.3;-1 1.5;-0.5 1];
t1=[1;1;-1;-1;1;1;-1;-1];
t2=[1;1;-1;-1;-1;-1;1;1];
figure(1)
plot([p(1,2),p(2,2)],[p(1,1),p(2,1)],'+')
hold on
plot([p(3,2),p(4,2)],[p(3,1),p(4,1)],'O')
hold on
plot([p(5,2),p(6,2)],[p(5,1),p(6,1)],'*')
hold on
plot([p(7,2),p(8,2)],[p(7,1),p(8,1)],'^')


x1=linspace(-1.5,1.2,20);
x2=-(wb(1)*b/w(2,1))*0.2-(w(1,1)/w(2,1))*x1;
plot(x2,x1,'b');
x3=-(wb(2)*b/w(2,2))*0.2-(w(1,2)/w(2,2))*x1;
plot(x3,x1,'b');
shg;
for j=1:100000
    for k=1:length(p)
    x=p(k,:);
    s1=w(1,1)*x(1)+w(2,1)*x(2)+wb(1)*b;
    s2=w(1,2)*x(1)+w(2,2)*x(2)+wb(2)*b;   
    y1=sign(s1);
    y2=sign(s2);
    if y1~=t1(k) || y2~=t2(k)
        delta_w11=gama*x(1)*t1(k);
        delta_w21=gama*x(2)*t1(k);
         delta_w12=gama*x(1)*t2(k);
        delta_w22=gama*x(2)*t2(k);
        delta_wb2=gama*t2(k);
        delta_wb1=gama*t1(k);
        w(1,1)=w(1,1)+delta_w11;
        w(2,1)=w(2,1)+delta_w21;
        wb(1)=wb(1)+delta_wb1;
        w(1,2)=w(1,2)+delta_w12;
        w(2,2)=w(2,2)+delta_w22;
         wb(2)=wb(2)+delta_wb2;
    end
    
       
    end
    
% % % % %      if  j/10==round (j/10)
% % % % %           e1(1,10)=0;e2(1,10)=0;
% % % % % 
% % % % %         for kk=1:length(p)
% % % % %             
% % % % %              x=p(kk,:);
% % % % %          s1=w(1,1)*x(1)+w(2,1)*x(2)+wb(1)*b;
% % % % %     s2=w(1,2)*x(1)+w(2,2)*x(2)+wb(2)*b;   
% % % % %     y1=sign(s1);
% % % % %     y2=sign(s2);
% % % % %             e1= e1(1,kk)+((t1(kk)-y1)^2);
% % % % %           
% % % % %             e2= e2(1,kk)+((t2(kk)-y2)^2);
% % % % %         end
% % % % %        if e1==0 & e2==0
% % % % %             break;
% % % % %         end
% % % % %     end
    
end       
 yy1=(-w(1,1)/w(2,1)*x1)-(wb(1)*0.2/w(2,1));
plot(yy1,x1,'k');
yy1=(-w(1,2)/w(2,2)*x1)-(wb(2)*0.2/w(2,2));
plot(yy1,x1,'k');
toc

        
        
        
        
        
        
        
        
        
        
      
        
        
    
   
        
        
    

    