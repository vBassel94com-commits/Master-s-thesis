clear 
clc
X=[0.5,-0.5,0.5,2,0.4,1.5,-0.5,-0.7,-0.9;
1.5,0.5,0.5,1.5,-0.2,-1,-0.5,-0.6,-0.6;
d=[1; 1; 1 ;1 ;1 ;1;-1;-1;-1];
w=0.5*rand(1,2);
b=0.2*rand;
axis([-2 2 -2 2])
figure(1)
plot(X(1,[1,2,3,4,5,6]),X(2,[1,2,3,4,5,6]),'+')
hold on
plot(X(1,[7,8,9]),X(2,[7,8,9]),'^')
plot([-2 2],-w(1)/w(2)*[-2 2]-b/w(2));
for j=1:1000
    r=floor(9*rand+1);
    s=w*X(:,r)+b;
    e=d(r)-s;
    w=w+0.2*e*X(:,r)';
    b=b+0.2*e;
    
    
    if round (j/10)==j/10
    err=0;
    for k=1:length(X)
    s=w*X(:,r)+b;
    y=sign(s);
    
    if d(k)~=y
        err=err+1;
    end
    
    
    end
    
    
    if err==0
        break;
        
        
    end
    end
    
    
    
    
end
plot([-2 2],-b/w(2)-w(1)/w(2)*[-2 2],'r');
 for k=1:length(X)
    s=w*X(:,k)+b;
    y=sign(s);
    disp(y)
 end
