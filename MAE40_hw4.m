%% Solving for system of equations
syms L C R Vin Vd Voutb ILb s Vs D f 
A = [ 0 0 -R 0 1 ; 
    -1 1 1 0 0 ;
    0 0 0 s -s;
    0 -1 0 0 C*s;
    L*s 0 0 -1 0];
b = [0;0;Vd;C*Voutb;L*ILb];
x = A\b;
Vout = simplify(x(5))
I_L = simplify(x(1))
%%
clear; Vs=5; Vd=0.5; L=10e-6; C=4.7e-6; R=250; f=1.6e6; D=0.6;
sigma=1/(2*R*C); omega_n=-1/sqrt(L*C); zeta=sigma/omega_n; omega_d=omega_n*sqrt(1-zeta^2);
v0=Vd; hA=D/f; hB=(1-D)/f; c1=cos(omega_d*hB); s1=sin(omega_d*hB);
A0=[1/R-C*sigma C*omega_d;-C*omega_d 1/R-C*sigma];
A1=[exp(-hA/(R*C)) 0; 0 1];                      b1=[0; Vs*hA/L];
A2=-([1 0;0 0]+[0 0;1 0]*A0);                    b2=[v0; v0/R];
A3=-exp(-sigma*hB)*([c1 s1;0 0]+[0 0;c1 s1]*A0); b3=b2;
sol=inv([eye(2)-A3*inv(A2)*A1])*(A3*inv(A2)*(b1-b2)+b3); VoutA=sol(1), ILA=sol(2)

%% Plot the periodic cycle for D> 0.5.
v0=Vd; i0=v0/R;
sol1=inv(A3)*(sol-b3); vc=sol1(1); vs=sol1(2);
sol2=A0*sol1;          ic=sol2(1); is=sol2(2);
tA=0; tB=D/f; tC=1/f; N=1000; t=0:tC/N:tC;
for i=1:N+1
	if t(i)<tB
		Vout(i)=VoutA*exp(-t(i)/(R*C));
		IL(i)  =ILA + t(i)*Vs/L;
	else
		tau=t(i)-tB;
		Vout(i)=v0-exp(-sigma*tau)*(vc*cos(omega_d*tau)+vs*sin(omega_d*tau));
		IL(i)  =i0-exp(-sigma*tau)*(ic*cos(omega_d*tau)+is*sin(omega_d*tau));
	end
end
figure(1); clf; plot(t,Vout)
axis([0 tC min(Vout) max(Vout)]); hold on
   Vmean=sum(Vout(1:N))/N, plot([0 tC],[Vmean Vmean],'k--');
   title('V_{out}(t) during periodic oscillation of buck-boost converter (D = .6; f=1.6e6)');
   % print -depsc boost_V.eps
figure(2); clf; plot(t,IL)
axis([0 tC min(IL) max(IL)]);  hold on
   Imean=sum(IL(1:N))/N;, plot([0 tC],[Imean Imean],'k--');
   title('I_{L}(t) during periodic oscillation of buck-boost converter (D = .6; f=1.6e6)');
   % print -depsc boost_I.eps
Imean_approx=(Vmean/R)/(1-D)

clear; Vs=5; Vd=0.5; L=10e-6; C=4.7e-6; R=250; f=1.6e6; D=0.3;
sigma=1/(2*R*C); omega_n=-1/sqrt(L*C); zeta=sigma/omega_n; omega_d=omega_n*sqrt(1-zeta^2);
v0=Vd; hA=D/f; hB=(1-D)/f; c1=cos(omega_d*hB); s1=sin(omega_d*hB);
A0=[1/R-C*sigma C*omega_d;-C*omega_d 1/R-C*sigma];
A1=[exp(-hA/(R*C)) 0; 0 1];                      b1=[0; Vs*hA/L];
A2=-([1 0;0 0]+[0 0;1 0]*A0);                    b2=[v0; v0/R];
A3=-exp(-sigma*hB)*([c1 s1;0 0]+[0 0;c1 s1]*A0); b3=b2;
sol=inv([eye(2)-A3*inv(A2)*A1])*(A3*inv(A2)*(b1-b2)+b3); VoutA=sol(1), ILA=sol(2)
%% Plot the periodic cycle for D<0.5.
v0=Vd; i0=v0/R;
sol1=inv(A3)*(sol-b3); vc=sol1(1); vs=sol1(2);
sol2=A0*sol1;          ic=sol2(1); is=sol2(2);
tA=0; tB=D/f; tC=1/f; N=1000; t=0:tC/N:tC;
for i=1:N+1
	if t(i)<tB
		Vout(i)=VoutA*exp(-t(i)/(R*C));
		IL(i)  =ILA + t(i)*Vs/L;
	else
		tau=t(i)-tB;
		Vout(i)=v0-exp(-sigma*tau)*(vc*cos(omega_d*tau)+vs*sin(omega_d*tau));
		IL(i)  =i0-exp(-sigma*tau)*(ic*cos(omega_d*tau)+is*sin(omega_d*tau));
	end
end
figure(3); clf; plot(t,Vout)
axis([0 tC min(Vout) max(Vout)]); hold on
   Vmean=sum(Vout(1:N))/N, plot([0 tC],[Vmean Vmean],'k--');
   title('V_{out}(t) during periodic oscillation of buck-boost converter (D = .3;f=1.6e6)');
   % print -depsc boost_V.eps
figure(4); clf; plot(t,IL)
axis([0 tC min(IL) max(IL)]);  hold on
   Imean=sum(IL(1:N))/N, plot([0 tC],[Imean Imean],'k--');
   title('I_{L}(t) during periodic oscillation of buck-boost converter (D = .3;f=1.6e6)');
   % print -depsc boost_I.eps
Imean_approx=(Vmean/R)/(1-D)