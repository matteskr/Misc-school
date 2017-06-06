% Question 3 for Assignement 3 4x03
n = 20000;
a = 0; b = 17.1;
h = (b-a)/n;
mu = 0.012277471;
muh = 1-mu;
f1 = @(t,y1,y2,y3,y4) y2;
f2 = @(t,y1,y2,y3,y4) y1 + 2*y4 - muh*((y1+mu)/(((y1+mu)^2 + y3^2)^(3/2))) - mu*((y1-muh)/(((y1-muh)^2 + y3^2)^(3/2)));
f3 = @(t,y1,y2,y3,y4) y4;
f4 = @(t,y1,y2,y3,y4) y3 - 2*y2 - muh*(y3/(((y1+mu)^2 + y3^2)^(3/2))) - mu*(y3/(((y1-muh)^2 + y3^2)^(3/2)));

t = zeros(1,n); t_a = a;
u1 = zeros(1,n); u1_0 = 0.994;
u2 = zeros(1,n); u2_0 = 0;
u3 = zeros(1,n); u3_0 = 0;
u4 = zeros(1,n); u4_0 = -2.001585106379082522420537862224;


t(1) = t_a;
u1(1) = u1_0;
u2(1) = u2_0;
u3(1) = u3_0;
u4(1) = u4_0;
for j = 1:n
    k1 = h*f1(t(j),u1(j),u2(j),u3(j),u4(j)); l1 = h*f2(t(j),u1(j),u2(j),u3(j),u4(j));
    m1 = h*f3(t(j),u1(j),u2(j),u3(j),u4(j)); n1 = h*f4(t(j),u1(j),u2(j),u3(j),u4(j));
    k2 = h*f1(t(j)+0.5*h,u1(j)+0.5*k1,u2(j)+0.5*l1,u3(j)+0.5*m1,u4(j)+0.5*n1); l2 = h*f2(t(j)+0.5*h,u1(j)+0.5*k1,u2(j)+0.5*l1,u3(j)+0.5*m1,u4(j)+0.5*n1);
    m2 = h*f3(t(j)+0.5*h,u1(j)+0.5*k1,u2(j)+0.5*l1,u3(j)+0.5*m1,u4(j)+0.5*n1); n2 = h*f4(t(j)+0.5*h,u1(j)+0.5*k1,u2(j)+0.5*l1,u3(j)+0.5*m1,u4(j)+0.5*n1);
    k3 = h*f1(t(j)+0.5*h,u1(j)+0.5*k2,u2(j)+0.5*l2,u3(j)+0.5*m2,u4(j)+0.5*n2); l3 = h*f2(t(j)+0.5*h,u1(j)+0.5*k2,u2(j)+0.5*l2,u3(j)+0.5*m2,u4(j)+0.5*n2);
    m3 = h*f3(t(j)+0.5*h,u1(j)+0.5*k2,u2(j)+0.5*l2,u3(j)+0.5*m2,u4(j)+0.5*n2); n3 = h*f4(t(j)+0.5*h,u1(j)+0.5*k2,u2(j)+0.5*l2,u3(j)+0.5*m2,u4(j)+0.5*n2);
    k4 = h*f1(t(j)+h,u1(j)+k3,u2(j)+l3,u3(j)+m3,u4(j)+n3); l4 = h*f2(t(j)+h,u1(j)+k3,u2(j)+l3,u3(j)+m3,u4(j)+n3);
    m4 = h*f3(t(j)+h,u1(j)+k3,u2(j)+l3,u3(j)+m3,u4(j)+n3); n4 = h*f4(t(j)+h,u1(j)+k3,u2(j)+l3,u3(j)+m3,u4(j)+n3);
    
    t(j+1) = t(j) + j*h;
    u1(j+1) = u1(j) + (1/6)*(k1+2*k2+2*k3+k4);
    u2(j+1) = u2(j) + (1/6)*(l1+2*l2+2*l3+l4);
    u3(j+1) = u3(j) + (1/6)*(m1+2*m2+2*m3+m4);
    u4(j+1) = u4(j) + (1/6)*(n1+2*n2+2*n3+n4);
end
plot(u1,u3);

