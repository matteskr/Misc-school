% Question 2 for Assignment 4 4x03

tol = 1e-6;
x_a=15; y_a=-2;
X_a=[x_a;y_a];
i=0;err=1;
while(err > tol && i<100)
    x_a=X_a(1);y_a=X_a(2);
    Jac=[1 -3*y_a^2+10*y_a-2; 1 3*y_a^2+2-14]; % hand calc
    Fa= [x_a-y_a^3+5*y_a^2-2*y_a-13; x_a+y_a^3+y_a^2-14*y_a-29]; % computed each iteration
    H=Jac\Fa;
    err=norm(H);
    X_a=X_a-H;
    i=i+1;
end
options=optimset('Display','off');
fun=@myfun1;
init=[15, -2];
[final,fval]=fsolve(fun,init,options);
fprintf('fsolve: %.3d,%.3d\n', final(1),final(2));
fprintf('Newt: %.3d,%.3d\n', x_a,y_a);
fprintf('i: %i\n\n', i);

x_b=(1+sqrt(3))/2; y_b=(1-sqrt(3))/2; z_b=sqrt(3);
X_b=[x_b;y_b;z_b];
i=0; err=1;
while(err>tol && i<100)
    x_b=X_b(1);y_b=X_b(2);z_b=X_b(3);
    Jac=[2*x_b 2*y_b 2*z_b; 1 1 0; 1 0 1]; % Jacobian computed by hand
    Fb= [x_b^2+y_b^2+z_b^2-5; x_b+y_b-1;x_b+z_b-3]; % computed each iteration
    H=Jac\Fb;
    err=norm(H);
    X_b=X_b-H;
    i=i+1;
end
options=optimset('Display','off');
fun=@myfun2;
init=[(1+sqrt(3))/2, (1-sqrt(3))/2, sqrt(3)];
[final,fval]=fsolve(fun,init,options);
fprintf('fsolve: %.3d ,%.3d, %.3d \n', final(1),final(2),final(3));
fprintf('Newt: %.3d, %.3d, %.3d\n', x_b,y_b,z_b);
fprintf('i: %i\n\n', i);

x_c=1;y_c=2;z_c=1;k_c=1;
X_c=[x_c;y_c;z_c;k_c];
i=0;err=1;
while(err>tol && i<100)
    x_c=X_c(1);y_c=X_c(2);z_c=X_c(3); k_c=X_c(4);
    Jac=[1 10 0 0;0 0 sqrt(5) -sqrt(5);0 2*y_c-2*z_c 2*z_c-2*y_c 0; ...
        2*sqrt(10)*(x_c-k_c) 0 0 2*sqrt(10)*(k_c-x_c)]; % computed by hand
    Fc= [x_c+10*y_c; sqrt(5)*(z_c-k_c);(y_c-z_c)^2;sqrt(10)*(x_c-k_c)^2];
    H=Jac\Fc;
    err=norm(H);
    X_c=X_c-H;
    i=i+1;
end
options=optimset('Display','off');
fun=@myfun3;
init=[1 2 1 1];
[final,fval]=fsolve(fun,init,options);
fprintf('fsolve: %d ,%d, %d, %d \n', final(1),final(2),final(3),final(4));
fprintf('Newt: %d, %d, %d, %d\n', x_c,y_c,z_c,k_c);
fprintf('i: %i\n\n', i);

x_d=1.8; y_d=0;
X_d=[x_d;y_d];
i=0; err=1;
while(err >tol && i<100)
    x_d=X_d(1);y_d=X_d(2);
    Jac=[1 0; 10/(x_d+0.1)-10*x_d/(x_d+0.1)^2 4*y_d];
    Fd= [x_d; 10*x_d/(x_d+0.1)+2*y_d^2]; 
    H=Jac\Fd;
    err=norm(H);
    X_d=X_d-H;
    i=i+1;
end
options=optimset('Display','off');
fun=@myfun4;
init=[1.8, 0];
[final,fval]=fsolve(fun,init,options);
fprintf('fsolve: %d,%.3d\n', final(1),final(2));
fprintf('Newt: %d,%.3d\n', x_d,y_d);
fprintf('i: %i\n\n', i);

x_e=0; y_e=0;
X_e=[x_e;y_e];
i=0;
err=1;
while(err >tol && i<100)
    x_e=X_e(1);y_e=X_e(2);
    Jac=[1e4*y_e 1e4*x_e; -exp(-x_e) -exp(-y_e)];
    Fe= [1e4*x_e*y_e-1; exp(-x_e)+exp(-y_e)-1.0001]; % computed each iteration
    H=Jac\Fe;
    err=norm(H);
    X_e=X_e-H;
    i=i+1;
end
options=optimset('Display','off');
fun=@myfun5;
init=[0, 0];
[final,fval]=fsolve(fun,init,options);
fprintf('fsolve: %d,%.3d\n', final(1),final(2));
fprintf('Newt: %d,%.3d\n', x_e,y_e);
fprintf('i: %i\n\n', i);


function F1 = myfun1(x)
    F1 = [x(1)+x(2)*(x(2).*(5-x(2))-2) - 13; 
        x(1)+x(2)*(x(2).*(1+x(2))-14) - 29];
    
end

function F2 = myfun2(x)
    F2 = [x(1).^2+x(2).^2+x(3).^2; 
        x(1)+x(2)-1;
        x(1)+x(3)-3];
end

function F3 = myfun3(x)
    F3 = [x(1)+10*x(2); 
         sqrt(5)*(x(3)-x(4));
         (x(2)-x(3))^2;
         sqrt(10)*(x(1)-x(4))^2];
end

function F4 = myfun4(x)
        F4 = [x(1); 
        10.*x(1)/(x(1)+0.1)+2.*x(2).^2];
end

function F5 = myfun5(x)
        F5 = [10.^4.*x(1).*x(2) - 1;
        exp(-x(1))+exp(-x(2))-1.0001];
end
