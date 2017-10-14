%---------------------------------------------------------------------
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo preliminar (exemplo 3)
%
%  Algoritmo : Método indireto
%
%  Ref. [Tao:2003], pag. 21 & 212
%                                                       Ramon R. Costa
%                                                       30/abr/13, Rio
%---------------------------------------------------------------------
clear all;
clc;

%---------------------------------------------------------------------
disp('-------------------------------')
disp('Script para simular o exemplo 3')
disp(' ')
disp('Caso: Planta ............. n = 1')
disp('      Grau relativo ..... n* = 1')
disp('      Parâmetros ........ np = 1')
disp(' ')
disp('Algoritmo: Método indireto')
disp(' ')
disp('-------------------------------')

%------------------------------------------------ Initialization -----
tfinal = 10;    %Simulation interval
st = 0.05;      %Sample time to workspace

s = tf('s');    %trick!

PRINT = 'ON';  %'ON' : imprimi diagramas

%--------------------------------------------------------- Plant -----
ap = -2;

p = 1/(s-ap);
P = ss(p);

%----------------------------------------------- Reference model -----
am = 1;

m = 1/(s+am);
M = ss(m);

%-------------------------------------------------------- Filter -----
af = 1;

%--------------------------------------------- Initial condition -----
yp0  = 0;
ym0  = 0;

%----------------------------------- Reference signal parameters -----
DC = 1;   %Constant

As = 0;   %Sine wave amplitude
ws = 2;  %Frequency

%------------------------------------------------- Matching gain -----
ks = -ap - am;

thetas_1 = ap + af;
thetas_2 = ap; 

%----------------------------------------- Adaptation parameters -----
gamma1 = 2;         %Adaptation gains
gamma2 = 100;
theta0 = 0;       %Adaptation inicial condition

%---------------------------------------------------- Simulation -----
gamma = gamma1
m_type = 1;
sim('MRAC_indireto_111_8_5',tfinal);

yp_g1 = yp;   %Save results
e0_g1 = e0;
yhat_g1 = yhat;
epsilon_g1 = epsilon;
theta_g1 = theta;
u_g1 = u;
k_g1 = k;

%---------------------------------------------------- Simulation -----
m_type = 2;
sim('MRAC_indireto_111_8_5',tfinal);

yp_g1ap = yp;   %Save results
e0_g1ap = e0;
yhat_g1ap = yhat;
epsilon_g1ap = epsilon;
theta_g1ap = theta;
u_g1ap = u;
k_g1ap = k;

%---------------------------------------------------- Simulation -----
m_type = 1;
gamma = gamma2
sim('MRAC_indireto_111_8_5',tfinal);

yp_g2 = yp;   %Save results
e0_g2 = e0;
yhat_g2 = yhat;
epsilon_g2 = epsilon;
theta_g2 = theta;
u_g2 = u;
k_g2 = k;

%---------------------------------------------------- Simulation -----
m_type = 2;
sim('MRAC_indireto_111_8_5',tfinal);

yp_g2ap = yp;   %Save results
e0_g2ap = e0;
yhat_g2ap = yhat;
epsilon_g2ap = epsilon;
theta_g2ap = theta;
u_g2ap = u;
k_g2ap = k;

%----------------------------------------------- Print eps plots -----
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');

par1 = strcat('$\theta = ap$');
par2 = strcat('$\theta = ap + af$');

apstr = strcat('ap',num2str(ap));
amstr = strcat('am',num2str(am));
yp0str = strcat('yp0',num2str(yp0));
afstr = strcat('af',num2str(af));

name = strcat(apstr,amstr,yp0str,afstr);
path_e0 = strcat('../relatorio_indireto/figs/e0/',name,'.eps');
path_epsilon = strcat('../relatorio_indireto/figs/epsilon/',name,'.eps');
path_theta = strcat('../relatorio_indireto/figs/theta/',name,'.eps');
path_u = strcat('../relatorio_indireto/figs/u/',name,'.eps');
path_k = strcat('../relatorio_indireto/figs/k/',name,'.eps');
path_yhat = strcat('../relatorio_indireto/figs/yhat/',name,'.eps');
path_yp = strcat('../relatorio_indireto/figs/yp/',name,'.eps');

%--------------- Fig1 -------------
figure(1);
clf;

subplot(211);
plot(t,e0_g1,t,e0_g1ap,'Linew',0.5);
grid on;
titleStr = strcat('$e_0$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

subplot(212)
plot(t,e0_g2,t,e0_g2ap,'Linew',0.5);
grid on
titleStr = strcat('$e_0$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

print(path_e0,'-depsc2') 

%--------------- Fig2 -------------
figure(2);
clf;

subplot(211);
plot(t,epsilon_g1,t,epsilon_g1ap,'Linew',0.5);
grid on;
titleStr = strcat('$\epsilon$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

subplot(212)
plot(t,epsilon_g2,t,epsilon_g2ap,'Linew',0.5);
grid on
titleStr = strcat('$\epsilon$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

print(path_epsilon,'-depsc2') 

%--------------- Fig3 -------------
figure(3);
clf;

Thetas1 = thetas_1*ones(size(t));
Thetas2 = thetas_2*ones(size(t));
subplot(211);
plot(t,theta_g1,t,theta_g1ap,t,Thetas1,t,Thetas2,'Linew',0.5);
grid on;
titleStr = strcat('$\theta$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'$\theta1$*','$\theta2$*','Location','SouthEast');

subplot(212)
plot(t,theta_g2,t,theta_g2ap,t,Thetas1,t,Thetas2,'Linew',0.5);
grid on
titleStr = strcat('$\theta$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'$\theta$*','$\theta2$*','Location','SouthEast');

print(path_theta,'-depsc2') 

%--------------- Fig4 -------------
figure(4);
clf;

Ks = ks*ones(size(t));
subplot(211);
plot(t,k_g1,t,k_g1ap,t,Ks,'Linew',0.5);
grid on;
titleStr = strcat('$k$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'$k$*','Location','SouthEast');

subplot(212)
plot(t,k_g2,t,k_g2ap,t,Ks,'Linew',0.5);
grid on
titleStr = strcat('$k$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'$k$*','Location','SouthEast');

print(path_k,'-depsc2') 

%--------------- Fig5 -------------
figure(5);
clf;

subplot(211);
plot(t,yhat_g1,t,yhat_g1ap,t,r,t,ym,'Linew',0.5);
grid on;
titleStr = strcat('$\hat{y}$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'r','ym','Location','SouthEast');

subplot(212)
plot(t,yhat_g2,t,yhat_g2ap,t,r,t,ym,'Linew',0.5);
grid on
titleStr = strcat('$\hat{y}$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'r','ym','Location','SouthEast');

print(path_yhat,'-depsc2') 

%--------------- Fig6 -------------
figure(6);
clf;

subplot(211);
plot(t,yp_g1,t,yp_g1ap,t,r,t,ym,'Linew',0.5);
grid on;
titleStr = strcat('$yp$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'r','ym','Location','SouthEast');

subplot(212)
plot(t,yp_g2,t,yp_g2ap,t,r,t,ym,'Linew',0.5);
grid on
titleStr = strcat('$yp$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'r','ym','Location','SouthEast');

print(path_yp,'-depsc2') 


%--------------------------------------- Impress?o dos diagramas -----
if strcmp(PRINT,'ON')
    open_system('MRAC_indireto_111_8_5');
    print -dsvg -sMRAC_111 ../relatorio_indireto/figs/MRAC_indireto111.svg
    
    open_system('MRAC_indireto_111_8_5/Plant');
    print -dsvg -sMRAC_111/Plant ../relatorio_indireto/figs/plant.svg
    
    open_system('MRAC_indireto_111_8_5/Model');
    print -dsvg '-sMRAC_111/Reference model' ../relatorio_indireto/figs/reference-model.svg
    
    open_system('MRAC_indireto_111_8_5/Adaptation');
    print -dsvg -sMRAC_111/Adaptation ../relatorio_indireto/figs/adaptation.svg
    
    open_system('MRAC_indireto_111_8_5/Reference signal');
    print -dsvg '-sMRAC_111/Reference signal' ../relatorio_indireto/figs/reference-signal.svg
    
    open_system('MRAC_indireto_111_8_5/Design');
    print -dsvg '-sMRAC_111/Reference signal' ../relatorio_indireto/figs/design.svg
    
    open_system('MRAC_indireto_111_8_5/Prediction');
    print -dsvg '-sMRAC_111/Reference signal' ../relatorio_indireto/figs/prediction.svg
    
    close_system('MRAC_indireto_111_8_5');
end


