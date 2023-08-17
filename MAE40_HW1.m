%Question 1
clear, close all, syms s Vi C L R
% Damped second-order low-pass LC filter: Solve for Vo as a function of Vi
% x={I_L,Ic, Ir, Vo}  <-- unknown vector
A  =[ -1  1   1 0;    % Ir+ Ic -I_L = 0
     L*s  0  0 1;    % L*s*I_L + Vo = Vi
     0  1 0  -C*s;   %C*s*Vo - Ic = 0
     0  0 R   -1];  % Ir*R -Vo = 0
b  =[ 0; Vi; 0 ; 0];
x=A\b; 
Vo_LPF2_damped=simplify(x(4))
%%
clear, close all
%Question 2
omega4=10;
zeta = .1
F_LPF2_damped=RR_tf([omega4^2],[1 2*zeta*omega4 omega4^2]);
figure(4); RR_bode(F_LPF2_damped)

%zeta = .7
zeta = .7
figure(5); F_LPF2_damped=RR_tf([omega4^2],[1 2*zeta*omega4 omega4^2]);

RR_bode(F_LPF2_damped)
%zeta = 1
zeta = 1
F_LPF2_damped=RR_tf([omega4^2],[1 2*zeta*omega4 omega4^2]);

figure(6); RR_bode(F_LPF2_damped)
%%
%Question 3
clear, close all, syms s Vi C L R Cd
% x={I_L,Ic, IR, ICd, Vo, V2}  <-- unknown vector
A  =[ 1 -1 -1 0 0 0;    % I_L - Ic + IR= 0
     L*s  0 0 0 1 0;    % L*s*I_L + Vo = Vi
     0 1 0 0 -C*s 0;    %C*s*Vo - Ic = 0
     0  0 -R 0 1 -1;    %Vo - V2- IR*R = 0
     0 0 0 1 0 -Cd*s;   %ICd - Cd*s*V2 = 0
     0 0  1 -1 0 0];    % IR - ICd = 0
b  =[ 0; Vi; 0 ; 0; 0; 0];
x=A\b;
Vo=simplify(x(5))