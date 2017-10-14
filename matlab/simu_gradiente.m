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
ws = 10;  %Frequency

%------------------------------------------------- Matching gain -----
thetas = -ap - am;   %theta*

%----------------------------------------- Adaptation parameters -----
gamma1 = 2;       %Adaptation gains
gamma2 = 100;
theta0 = 0;       %Adaptation inicial condition
af = 0.5;

%---------------------------------------------------- Simulation -----
m_type = 1; %without dotzeta

gamma = gamma1
sim('MRAC_111_8_5',tfinal);

yp_g1 = yp;   %Save results
e0_g1 = e0;
theta_g1 = theta;
u_g1 = u;

%---------------------------------------------------- Simulation -----
m_type = 2; %with dotzeta

sim('MRAC_111_8_5',tfinal);

yp_g1dz = yp;   %Save results
e0_g1dz = e0;
theta_g1dz = theta;
u_g1dz = u;

%---------------------------------------------------- Simulation -----
m_type = 1; %without dotzeta
gamma = gamma2
sim('MRAC_111_8_5',tfinal);

yp_g2 = yp;   %Save results
e0_g2 = e0;
theta_g2 = theta;
u_g2 = u;


%---------------------------------------------------- Simulation -----
m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);

yp_g2dz = yp;   %Save results
e0_g2dz = e0;
theta_g2dz = theta;
u_g2dz = u;

%----------------------------------------------- Print eps plots -----
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');

par1 = strcat('$m^2 = 1 + \zeta^2$');
par2 = strcat('$m^2 = 1 + \zeta^2 + \dot{\zeta}^2$');

apstr = strcat('ap',num2str(ap));
amstr = strcat('am',num2str(am));
yp0str = strcat('yp0',num2str(yp0));
afstr = strcat('af',num2str(af));

name = strcat(apstr,amstr,yp0str,afstr);
path_e0 = strcat('../relatorio/figs/e0/',name,'.eps');
path_e0_vs_deltatheta = strcat('../relatorio/figs/e0_vs_deltatheta/',name,'.eps');
path_theta = strcat('../relatorio/figs/theta/',name,'.eps');
path_u = strcat('../relatorio/figs/u/',name,'.eps');
path_yp = strcat('../relatorio/figs/yp/',name,'.eps');

%--------------- Fig1 -------------
figure(1);
clf;

subplot(211);
plot(t,e0_g1,t,e0_g1dz,'Linew',0.5);
grid on;
titleStr = strcat('$e_0$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

subplot(212)
plot(t,e0_g2,t,e0_g2dz,'Linew',0.5);
grid on
titleStr = strcat('$e_0$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

print(path_e0,'-depsc2') 

%--------------- Fig2 -------------
Thetas = thetas*ones(size(t));
figure(2);
clf;

subplot(211);
plot(t,theta_g1,t,theta_g1dz,t,Thetas,'Linew',0.5);
grid on;
titleStr = strcat('$\theta$, $\theta*$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'$\theta$*','Location','SouthEast')

subplot(212);
plot(t,theta_g2,t,theta_g2dz,t,Thetas,'Linew',0.5);
grid on;
titleStr = strcat('$\theta$, $\theta*$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'$\theta$*','Location','SouthEast')

print(path_theta,'-depsc2')

%--------------- Fig3 -------------
figure(3);
clf;

subplot(211);
hold on;
plot(t,yp_g1)
plot(t,yp_g1dz,t,r,t,ym,'Linew',0.5)
grid on
titleStr = strcat('$r$, $y_m$, $y_p$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'$r$','$y_m$','Location','SouthEast')

subplot(212);
hold on;
plot(t,yp_g2)
plot(t,yp_g2dz,t,r,t,ym,'Linew',0.5)
grid on
titleStr = strcat('$r$, $y_m$, $y_p$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'$r$','$y_m$','Location','SouthEast')

print(path_yp,'-depsc2')

%--------------- Fig4 -------------
deltatheta_g1 = theta_g1 - thetas;
deltatheta_g2 = theta_g2 - thetas;
deltatheta_g1dz = theta_g1dz - thetas;
deltatheta_g2dz = theta_g2dz - thetas;
figure(4);
clf;

subplot(121);
hold on
plot(e0_g1,deltatheta_g1)
plot(e0_g1dz,deltatheta_g1dz)
grid on
%axis equal
titleStr = strcat('$e_0$ vs. $\tilde{\theta}$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
xlabel('$e_0$')
ylabel('$\tilde{\theta}$')
legend(par1,par2,'Location','SouthEast')

subplot(122);
hold on
plot(e0_g2,deltatheta_g2)
plot(e0_g2dz,deltatheta_g2dz)
grid on
%axis equal
titleStr = strcat('$e_0$ vs. $\tilde{\theta}$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
xlabel('$e_0$')
ylabel('$\tilde{\theta}$')
legend(par1,par2,'Location','SouthEast')

print(path_e0_vs_deltatheta,'-depsc2')

%--------------- Fig5 -------------
figure(5)
clf

subplot(211)
hold on
plot(t,u_g1)
plot(t,u_g1dz,'Linew',0.5)
grid on
titleStr = strcat('$u$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast')

subplot(212)
hold on
plot(t,u_g2)
plot(t,u_g2dz,'Linew',0.5)
grid on
titleStr = strcat('$u$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast')

print(path_u, '-depsc2')

%--------------------------------------- Impress?o dos diagramas -----
if strcmp(PRINT,'ON')
    open_system('MRAC_111_8_5');
    print -dsvg -sMRAC_111 ../relatorio/figs/MRAC_111_8_5.svg
    
    open_system('MRAC_111_8_5/Plant');
    print -dsvg -sMRAC_111/Plant ../relatorio/figs/plant.svg
    
    open_system('MRAC_111_8_5/Reference model');
    print -dsvg '-sMRAC_111/Reference model' ../relatorio/figs/reference-model.svg
    
    open_system('MRAC_111_8_5/Adaptation');
    print -dsvg -sMRAC_111/Adaptation ../relatorio/figs/adaptation.svg
    
    open_system('MRAC_111_8_5/Reference signal');
    print -dsvg '-sMRAC_111/Reference signal' ../relatorio/figs/reference-signal.svg
    
    close_system('MRAC_111_8_5');
end
