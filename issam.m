clear
clc
w=0.2*rand(2,2);
b=rand(1,2);
gamma=0.8;
x=[0 1;1 0;0 -1;-1 0;0 2; 2 0;0 -2 ;-2 0];
d=[-1 -1;-1 1;1 1;1 -1;-1 -1;-1 1;1 1;1 -1];
figure(1)
hold on
plot(x(1,2),x(1,1),'*')
plot(x(2,2),x(2,1),'*')
plot(x(3,2),x(3,1),'*')
plot(x(4,2),x(4,1),'*')
axis([-2 2.5 -2 2.5]) 
x1=linspace(-2,2.5,30);
x2=-w(1,1)/w(1,2)*x1-b(1,1)/w(1,2);
plot(x2,x1,'r')
x3=-w(2,1)/w(2,2)*x1-b(1,2)/w(2,2);
plot(x3,x1,'r')
for j=1:1000
for k=1:length(x)
p=x(k,:);
wb=b*0.2;
s=w*p'+wb';
y=sign(s);
if y~=d(k,:)'
de_w11=gamma*p(1)*d(k,1);
de_w12=gamma*p(1)*d(k,2);
de_w21=gamma*p(2)*d(k,1);
de_w22=gamma*p(2)*d(k,2);
de_b1=gamma*d(k,1);
de_b2=gamma*d(k,2);
w=w+[de_w11 de_w12;de_w21 de_w22];
b=b+[de_b1,de_b2];
end
end
if (j/10)==round(j/10)
e=0;
for kk=1:length(x)
p=x(kk,:);
s=w*p'+b';
y=sign(s);
e=e+(d(kk,:)-y').^2;
end
if e==0
break
end
end
end
for kkk=1:length(x)
p=x(kkk,:);
b=0.2*b;
s=w*p'+wb';
y=sign(s);
d(kkk);
end
yy1=-w(1,1)/w(1,2)*x1-b(1,1)/w(1,2);
yy2=-w(2,1)/w(2,2)*x1-b(1,2)/w(2,2);
plot(yy1,x1,'g')
plot(yy2,x1,'g')
