% Question 4 for Assignment 4 4x03

[t,y]= ode45(@dydt,[0 100],[0;1 ;0]);
[t_1,y_1]= ode45(@dydt,[0 100],[1e-10;1+1e-10 ;1e-10]);
plot(t,y(:,1),t,y(:,2),t,y(:,3))
title('Lorenz ode');

figure;plot(y(:,1),y(:,2));title('y1 & y2');
figure;plot(y_1(:,1),y_1(:,2));title('y1 & y2 distorted');
figure;plot(y(:,1),y(:,3));title('y1 & y3');
figure;plot(y_1(:,1),y_1(:,3));title('y1 & y3 distorted');
figure;plot(y(:,2),y(:,3));title('y2 & y3');
figure;plot(y_1(:,2),y_1(:,3));title('y2 & y3 distorted');

function odefun=dydt(t,y)
odefun=zeros(3,1);
sig = 10;
r = 28;
b = 8/3;
odefun(1)= sig*(y(2)-y(1));
odefun(2)= r*y(1)-y(2)-y(1)*y(3);
odefun(3)= y(1)*y(2)-(b)*y(3);
end