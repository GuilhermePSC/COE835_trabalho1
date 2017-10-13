%---------------------------------------------------------------------
%  COE-835  Controle adaptativo
%
%  Script para simular o exemplo 2
%                                                       Ramon R. Costa
%                                                       01/out/09, Rio
%---------------------------------------------------------------------
clear all;
clc;

%---------------------------------------------------------------------
disp('-------------------------------')
disp('Script para simular o exemplo 2')
disp(' ')
disp('Caso: Planta ............. n = 1')
disp('      Grau relativo ..... n* = 1')
disp('      Parametros ........ np = 1')
disp(' ')
disp('Algoritmo: Gradiente normalizado')
disp(' ')
disp('-------------------------------')

%------------------------------------------------ Initialization -----
tfinal = 10;    %Simulation interval
st = 0.05;      %Sample time to workspace

s = tf([1 0],[0 1]);    %trick!

PRINT = 'ON';  %'ON' : imprime diagramas

%--------------------------------------------------------- Plant -----
ap = -2;

P = 1/(s-ap);
P = ss(P);

%----------------------------------------------- Reference model -----
am = 1;

M = 1/(s+am);
M = ss(M);

%--------------------------------------------- Initial condition -----
yp0  = 0;
x0   = yp0;

ym0  = 0;
xm0  = ym0;

%----------------------------------- Reference signal parameters -----
DC = 1;   %Constant

As = 0;   %Sine wave amplitude
ws = 3;  %Frequency

%------------------------------------------------- Matching gain -----
thetas = -ap - am;   %theta*

%----------------------------------------- Adaptation parameters -----
gamma1 = 10;       %Adaptation gains
gamma2 = 100;
theta0 = 0;       %Adaptation inicial condition

mu = 0

%---------------------------------------------------- Simulation -----
m_type = 1; %without dotzeta

gamma = gamma1
sim('MRAC_111',tfinal);

yp1_1 = yp;   %Save results
e01_1 = e0;
theta1_1 = theta;
u1_1 = u;

%---------------------------------------------------- Simulation -----
m_type = 2; %with dotzeta

gamma = gamma1;
sim('MRAC_111',tfinal);

yp1_2 = yp;   %Save results
e01_2 = e0;
theta1_2 = theta;
u1_2 = u;

%---------------------------------------------------- Simulation -----
m_type = 1; %without dotzeta

gamma = gamma2
sim('MRAC_111',tfinal);

yp2_1 = yp;   %Save results
e02_1 = e0;
theta2_1 = theta;
u2_1 = u;

%---------------------------------------------------- Simulation -----
m_type = 2; %without dotzeta

gamma = gamma2;
sim('MRAC_111',tfinal);

yp2_2 = yp;   %Save results
e02_2 = e0;
theta2_2 = theta;
u2_2 = u;

%----------------------------------------------- Print eps plots -----
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');

par1 = strcat('$m^2 = 1 + \zeta^2$');
par2 = strcat('$m^2 = 1 + \zeta^2 + \dot{\zeta}^2$');

%--------------- Fig1 -------------
figure(1);
clf;

subplot(211);
plot(t,e01_1,t,e01_2,'Linew',0.5);
grid on;
titleStr = strcat('$e_0$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

subplot(212)
plot(t,e02_1,t,e02_2,'Linew',0.5);
grid on
titleStr = strcat('$e_0$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

print -depsc2 ../relatorio/figs/fig01a.eps

%--------------- Fig2 -------------
Thetas = thetas*ones(size(t));
figure(2);
clf;

subplot(211);
plot(t,theta1_1,t,theta1_2,t,Thetas,'Linew',0.5);
grid on;
titleStr = strcat('$\theta$, $\theta*$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'$\theta$*','Location','SouthEast')

subplot(212);
plot(t,theta2_1,t,theta2_2,t,Thetas,'Linew',0.5);
grid on;
titleStr = strcat('$\theta$, $\theta*$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'$\theta$*','Location','SouthEast')

print -depsc2 ../relatorio/figs/fig01b.eps

%--------------- Fig3 -------------
figure(3);
clf;

subplot(211);
hold on;
plot(t,yp1_1)
plot(t,yp1_2,t,r,t,ym,'Linew',0.5)
grid on
titleStr = strcat('$r$, $y_m$, $y_p$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'$r$','$y_m$','Location','SouthEast')

subplot(212);
hold on;
plot(t,yp2_1)
plot(t,yp2_2,t,r,t,ym,'Linew',0.5)
grid on
titleStr = strcat('$r$, $y_m$, $y_p$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'$r$','$y_m$','Location','SouthEast')

print -depsc2 ../relatorio/figs/fig01c.eps

%--------------- Fig4 -------------
ttheta1_1 = theta1_1 - thetas;
ttheta1_2 = theta1_2 - thetas;
ttheta2_1 = theta2_1 - thetas;
ttheta2_2 = theta2_2 - thetas;
figure(4);
clf;

subplot(121);
hold on
plot(e01_1,ttheta1_1)
plot(e01_2,ttheta1_2)
grid on
%axis equal
titleStr = strcat('$e_0$ vs. $\tilde{\theta}$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
xlabel('$e_0$')
ylabel('$\tilde{\theta}$')
legend(par1,par2,'Location','SouthEast')

subplot(122);
hold on
plot(e02_1,ttheta2_1)
plot(e02_2,ttheta2_2)
grid on
%axis equal
titleStr = strcat('$e_0$ vs. $\tilde{\theta}$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
xlabel('$e_0$')
ylabel('$\tilde{\theta}$')
legend(par1,par2,'Location','SouthEast')

print -depsc2 ../relatorio/figs/fig01d.eps

%--------------- Fig5 -------------
figure(5)
clf

subplot(211)
hold on
plot(t,u1_1)
plot(t,u1_2,'Linew',0.5)
grid on
titleStr = strcat('$u$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast')

subplot(212)
hold on
plot(t,u2_1)
plot(t,u2_2,'Linew',0.5)
grid on
titleStr = strcat('$u$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast')

print -depsc2 ../relatorio/figs/fig01e.eps

%------------------------------------------------- Display plots -----
% figure(6)
% clf
% 
% subplot(221)
% hold on
% plot(t,e01_1)
% plot(t,e02_1,'Linew',0.5);
% grid on
% title('e_0')
% legend(par1,par2,'Location','SouthEast')
% 
% subplot(222)
% hold on
% plot(t,theta1_1)
% plot(t,theta2_1,t,Thetas,'r','Linew',0.5);
% grid on; 
% title('\theta, \theta*')
% legend(par1,par2,'\theta*','Location','SouthEast')
% 
% subplot(223)
% hold on
% plot(t,yp1_1);
% plot(t,yp2_1,t,r,t,ym,'Linew',0.5);
% grid on
% title('r, y_m, y_p')
% legend(par1,par2,'r','y_m','Location','SouthEast')
% 
% subplot(224)
% hold on
% plot(t,u1_1)
% plot(t,u2_1,'Linew',0.5);grid;
% grid on
% title('u')
% legend(par1,par2,'Location','SouthEast')

%--------------------------------------- Impress�o dos diagramas -----
if strcmp(PRINT,'ON')
    open_system('MRAC_111');
    print -depsc2 -sMRAC_111 ../relatorio/figs/MRAC-111.eps
    
    open_system('MRAC_111/Plant');
    print -depsc2 -sMRAC_111/Plant ../relatorio/figs/plant.eps
    
    open_system('MRAC_111/Reference model');
    print -depsc2 '-sMRAC_111/Reference model' ../relatorio/figs/reference-model.eps
    
    open_system('MRAC_111/Adaptation');
    print -depsc2 -sMRAC_111/Adaptation ../relatorio/figs/adaptation.eps
    
    open_system('MRAC_111/Reference signal');
    print -depsc2 '-sMRAC_111/Reference signal' ../relatorio/figs/reference-signal.eps
    
    close_system('MRAC_111');
end

%---------------------------------------------------------------------


