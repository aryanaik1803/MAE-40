%Question 1
clear, close all, syms s Vi C L R Rload c1
% x={Vo, Vm, Ic, I_L, Ir, Ir_load}  <-- unknown vector
A  =[ 0  0   1  -1 0 0;    % Ic -I_L = 0
     0  0 1 0 -1 -1;    % Ic - Ir - Ir_load = 0
     0 1 0 L*s 0 0;   %LsI_L +Vm = Vi
     C*s  -C*s 1 0 0 0; %Ic - Cs(Vm)+Cs(Vo) = 0
     1 0 0 0 -R 0;      %Vo - Ir*R = 0
     1 0  0 0 0 -R/c1];  % Vo - Ir_load*R/c1 = 0
b  =[ 0; 0; Vi ; 0; 0; 0];
x=A\b;
Vo=simplify(x(1))
omega=10;
Q = 5;
F_LPF2_damped=RR_tf([omega/Q 0],[1 omega/Q omega^2]);
figure(1); RR_bode(F_LPF2_damped)
F_LPF3_damped=RR_tf([.5*omega/Q 0],[1 .5*omega/Q omega^2]);

g.linestyle = "-.";RR_bode(F_LPF3_damped,g)
%% 
%Question 2
%plot of V
omega = 10;
V = @(t) abs(10*sin(omega*t));
figure(2);
fplot(V, 'm')
hold on
%Plot of I
R = 20;
I = @(t) abs(10*sin(omega*t))/R;
fplot(I, 'b')
%Plot of P
P = @(t) abs(10*sin(10*t))*(abs(10*sin(10*t))/20);
fplot(P,'g')
legend('V(t)', 'I(t)', 'P(t)')
hold off
%%
% plot of P_diodes
% diodes only slightly change voltage, hence delta V is very small
clear all;
P_diode = @(t) .5 *abs(10*sin(10*t))
fplot(P_diode)
e = @(t) (.5 *abs(10*sin(10*t)))/((.5 *abs(10*sin(10*t))) + (abs(10*sin(10*t))*(abs(10*sin(10*t))/20)));
fplot(e)