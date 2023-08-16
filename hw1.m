clear all; close all; clc; format long;
name = 'Arya Naik';
id = 'A16730633';
hw_num = 1;
%%
%Problem 1 
x = -1:.02:1;
f = cos(x);
t0 = my_cos(x,0);
t1 = my_cos(x,1);
t2 = my_cos(x,2);
t3 = my_cos(x,3);
p1 = 'See figure 1';
%%
figure(1)
subplot(2,1,1);
plot (x,t0,'--k',x,t1,'--r',x,t2,'--b',x,t3,'--g',x,f,'m','LineWidth',2);

xlabel('x'); ylabel('t_n(x) and f');
axis tight; box on; grid on;
title('(a) Taylor polynomials t_n(x) for f = cos(x)');
legend('n = 0', 'n=1', 'n=2', 'n=3', 'f = cos(x)', 'location', 'northwest')
set(gca, 'fontsize', 12)


subplot(2,1,2);
semilogy(x,abs(f-t0),'--k',x,abs(f-t1),'--r',x,abs(f-t2),'--b',x,abs(f-t3),'--g', 'LineWidth', 2);

xlabel('x'); ylabel('absolute error \epsilon');
axis tight; box on; grid on;
title('(b) Error corresponding to t_n(x)');
set(gca, 'FontSize', 12);
%%
%Problem 2
%(a,b) Find the root of f (x) = e^−x2 sin(5x) with ε = 10−4 and [a, b] = [0.51, 2]. Put the root in p2a and the corresponding number of steps in p2b.
f = @(x) sin(5*x)*exp(-(x.^2));
epsilon = 10^-4;
a = .51;
b = 2;
[xn, n] =  my_bisection(f, a, b, epsilon);
p2a = xn
p2b = n

%%
%(c,d) Repeat parts (a, b) with the new interval [a, b] = [0.52, 2]. Put the root in p2c and the corresponding number of steps in p2d.
f = @(x) sin(5*x)*exp(-(x.^2));
epsilon = 10^-4;
a = .52;
b = 2;
[xn, n] =  my_bisection(f, a, b, epsilon);
p2c = xn
p2d = n
%%
%(e,f) Repeat parts (a, b) with the new interval [a, b] = [0.52, 2]. Put the root in p2c and the corresponding number of steps in p2d.
f = @(x) sin(x+(10^-10));
epsilon = 10^-4;
a = -2.5*pi;
b = 2.5*pi;
[xn, n] =  my_bisection(f, a, b, epsilon);
p2e = xn
p2f = n