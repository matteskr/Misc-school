% Question 1 for Assignment 4 4x03
x = 1.92:h:2.08; n = 9;
h = (2.08-1.92)/161;
f = @(x) ((x-2).^9);
fun1 = f(x);fun2 = zeros(1,161);
pnts = 1;
a = [-512 2304 -4608 5376 -4032 2016 -672 144 -18 1];
b = zeros(1,n+1);
for i = x
    b(n+1) = a(n+1);
    for j = n:-1:1
        b(1,j) = a(1,j) + i*b(1,(j+1));
    end
    fun2(1,pnts) = b(1,1);
    pnts = pnts + 1;
end

figure;
plot(x,fun1); title('[x-2]^9'); 
figure; 
plot(x,fun2); title('Horners function'); 

f3 =@(x) x.*(x.*(x.*(x.*(x.*(x.*(x.*(x.*(x - 18) + 144) - 672) + 2016) - 4032) + 5376) - 4608) + 2304) - 512;
[a,b,c,d, var, r] = Bisec(fun2, 1.92, 2.08, 100, 1e-6); r
error = abs(r-2)

fd =@(x) x.^9 - 18.*x.^8 + 144.*x.^7 - 672.*x.^6 + 2016.*x.^5 - 4032.*x.^4 + 5376.*x.^3 - 4608.*x.^2 + 2304.*x - 512;
fsolve(fd,1.9)
function [a,b,fa,fb, var, c] = Bisec(f,a,b,max,eps)
    a0 = a;
    h = (b-a)/161;
    fa = f(1);
    fb = f((b - a0)/h);
    error = b-a;var = 0;
    for n = 0:max
        error = error/2;
        c = a+error;
        fc = f(round((c - a0)/h));
        var = var + 1;
        if abs(error) < eps
            fprintf('Conv, %i %i', n, error);
            return;
        end
        if sign(fa)~=sign(fc)
            b = c; fb = fc;
        else
            a = c;fa = fc;
        end
    end
end