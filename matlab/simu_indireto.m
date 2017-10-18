%---------------------------------------------------------------------
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo preliminar (exemplo 3)
%
%  Algoritmo : Mï¿½todo indireto
%
%  Ref. [Tao:2003], pag. 21 & 212
%                                                       Ramon R. Costa
%                                                       30/abr/13, Rio
%---------------------------------------------------------------------
clear all;
clc;

%---------------------------------------------------------------------
disp('-------------------------------')
disp('Script para simular MRAC Indireto')
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

PRINT = 'OFF';  %'ON' : imprime diagramas


% --------------- Default Parameters --------------------

%Plant Parameters
ap1 = -2;
ap2 = -2;

%Reference Model Parameters
am1 = 1;
am2 = 1;

%Filter
af1 = 1;
af2 = 1;

%Initial condition
yp01  = 0;
yp02 = 0;
ym0  = 0;

%Reference signal parameters
DC = 1;   %Constant
As = 0;   %Sine wave amplitude
ws = 2;  %Frequency

%Matching gain
ks = -ap - am;
thetas_1 = ap + af;
thetas_2 = ap; 

%Adaptation parameters
gamma1 = 2;         %Adaptation gains
gamma2 = 2;
theta0 = 0;       %Adaptation inicial condition
changed = '';

%---------------------Simulation 1

ap = ap1;
am = am1;
gamma = gamma1;
yp0 = yp01;

% Model
m = 1/(s+am);
M = ss(m);

% Plant
p = 1/(s-ap);
P = ss(p);

%theta = ap + af
m_type = 1;
sim('MRAC_indireto_111_8_5',tfinal);

yp_11 = yp;   %Save results
e0_11 = e0;
yhat_11 = yhat;
epsilon_11 = epsilon;
theta_11 = theta;
u_11 = u;
k_11 = k;

%theta = ap
m_type = 2;
sim('MRAC_indireto_111_8_5',tfinal);

yp_12 = yp;   %Save results
e0_12 = e0;
yhat_12 = yhat;
epsilon_12 = epsilon;
theta_12 = theta;
u_12 = u;
k_12 = k;

%---------------------Simulation 1

ap = ap2;
am = am2;
gamma = gamma2;
yp0 = yp02;

% Model
m = 1/(s+am);
M = ss(m);

% Plant
p = 1/(s-ap);
P = ss(p);

%theta = ap + af
m_type = 1;
sim('MRAC_indireto_111_8_5',tfinal);

yp_21 = yp;   %Save results
e0_21 = e0;
yhat_21 = yhat;
epsilon_21 = epsilon;
theta_21 = theta;
u_21 = u;
k_21 = k;

%theta = ap
m_type = 2;
sim('MRAC_indireto_111_8_5',tfinal);

yp_22 = yp;   %Save results
e0_22 = e0;
yhat_22 = yhat;
epsilon_22 = epsilon;
theta_22 = theta;
u_22 = u;
k_22 = k;

%----------------------------------------------- Print eps plots -----
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');

par1 = strcat('$\theta = a_p$');
par2 = strcat('$\theta = a_p + a_f$');

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
titleStr = strcat('$e_0$ com', changed, '=', num2str(gamma1), '$');
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

%--------------- Fig7 -------------
figure(7)
clf

subplot(211)
hold on
plot(t,u_g1)
plot(t,u_g1ap,'Linew',0.5)
grid on
titleStr = strcat('$u$ com $\gamma = ',num2str(gamma1), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast')

subplot(212)
hold on
plot(t,u_g2)
plot(t,u_g2ap,'Linew',0.5)
grid on
titleStr = strcat('$u$ com $\gamma = ',num2str(gamma2), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast')

print(path_u, '-depsc2')


%--------------------------------------- Impress?o dos diagramas -----
if strcmp(PRINT,'ON')
    open_system('MRAC_indireto_111_8_5');
    print -depsc2 '-sMRAC_indireto_111_8_5' ../relatorio_indireto/figs/MRAC_indireto111.eps
    
    open_system('MRAC_indireto_111_8_5/Plant');
    print -depsc2 '-sMRAC_indireto_111_8_5/Plant' ../relatorio_indireto/figs/plant.eps
    
    open_system('MRAC_indireto_111_8_5/Model');
    print -depsc2 '-sMRAC_indireto_111_8_5/Model' ../relatorio_indireto/figs/reference-model.eps
    
    open_system('MRAC_indireto_111_8_5/Adaptation');
    print -depsc2 '-sMRAC_indireto_111_8_5/Adaptation' ../relatorio_indireto/figs/adaptation.eps
    
    open_system('MRAC_indireto_111_8_5/Adaptation/Normalization');
    print -depsc2 -sMRAC_indireto_111_8_5/Adaptation/Normalization ../relatorio_indireto/figs/normalization.eps
    
    open_system('MRAC_indireto_111_8_5/Reference signal');
    print -depsc2 '-sMRAC_indireto_111_8_5/Reference signal' ../relatorio_indireto/figs/reference-signal.eps
    
    open_system('MRAC_indireto_111_8_5/Design');
    print -depsc2 '-sMRAC_indireto_111_8_5/Design' ../relatorio_indireto/figs/design.eps
    
    open_system('MRAC_indireto_111_8_5/Prediction');
    print -depsc2 '-sMRAC_indireto_111_8_5/Prediction' ../relatorio_indireto/figs/prediction.eps
    
    close_system('MRAC_indireto_111_8_5');
end
