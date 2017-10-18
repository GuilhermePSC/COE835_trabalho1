
%----------------------------------------------- Print eps plots -----
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');

par1 = strcat('$m^2 = 1 + \zeta^2$');
par2 = strcat('$m^2 = 1 + \zeta^2 + \dot{\zeta}^2$');

path_e0 = strcat('../relatorio/figs/e0/',name,'.eps');
path_e0_vs_deltatheta = strcat('../relatorio/figs/e0_vs_deltatheta/',name,'.eps');
path_theta = strcat('../relatorio/figs/theta/',name,'.eps');
path_u = strcat('../relatorio/figs/u/',name,'.eps');
path_yp = strcat('../relatorio/figs/yp/',name,'.eps');

%--------------- Fig1 -------------
figure(1);
clf;

h1 = subplot(211);
plot(t,e0_g1,t,e0_g1dz,'Linew',0.5);
grid on;
titleStr = strcat('$e_0$ com $', paramstr, ' = ', num2str(param1), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

h2 = subplot(212);
plot(t,e0_g2,t,e0_g2dz,'Linew',0.5);
grid on
titleStr = strcat('$e_0$ com $', paramstr, ' = ', num2str(param2), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast');

%Reduce gap btw subplots
pos_pct = .05;
set(h2,'Position',[h2.Position(1), h2.Position(2) + pos_pct*(h1.Position(2) - h2.Position(2)), h2.Position(3), h2.Position(4)]);

print(path_e0,'-depsc2') 

%--------------- Fig2 -------------
Thetas = thetas*ones(size(t));
figure(2);
clf;

h1 = subplot(211);
plot(t,theta_g1,t,theta_g1dz,t,Thetas,'Linew',0.5);
grid on;
titleStr = strcat('$\theta$, $\theta*$ com $', paramstr, ' = ', num2str(param1), '$');
title(titleStr);
legend(par1,par2,'$\theta$*','Location','SouthEast')

h2 = subplot(212);
plot(t,theta_g2,t,theta_g2dz,t,Thetas,'Linew',0.5);
grid on;
titleStr = strcat('$\theta$, $\theta*$ com $', paramstr, ' = ', num2str(param2), '$');
title(titleStr);
legend(par1,par2,'$\theta$*','Location','SouthEast')

%Reduce gap btw subplots
pos_pct = .05;
set(h2,'Position',[h2.Position(1), h2.Position(2) + pos_pct*(h1.Position(2) - h2.Position(2)), h2.Position(3), h2.Position(4)]);

print(path_theta,'-depsc2')

%--------------- Fig3 -------------
figure(3);
clf;

h1 = subplot(211);
hold on;
plot(t,yp_g1)
plot(t,yp_g1dz,t,r,t,ym,'Linew',0.5)
grid on
titleStr = strcat('$r$, $y_m$, $y_p$ com $', paramstr, ' = ', num2str(param1), '$');
title(titleStr);
legend(par1,par2,'$r$','$y_m$','Location','SouthEast')

h2 = subplot(212);
hold on;
plot(t,yp_g2)
plot(t,yp_g2dz,t,r,t,ym,'Linew',0.5)
grid on
titleStr = strcat('$r$, $y_m$, $y_p$ com $', paramstr, ' = ', num2str(param2), '$');
title(titleStr);
legend(par1,par2,'$r$','$y_m$','Location','SouthEast')

%Reduce gap btw subplots
pos_pct = .05;
set(h2,'Position',[h2.Position(1), h2.Position(2) + pos_pct*(h1.Position(2) - h2.Position(2)), h2.Position(3), h2.Position(4)]);

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
titleStr = strcat('$e_0$ vs. $\tilde{\theta}$ com $', paramstr, ' = ', num2str(param1), '$');
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
titleStr = strcat('$e_0$ vs. $\tilde{\theta}$ com $', paramstr, ' = ', num2str(param2), '$');
title(titleStr);
xlabel('$e_0$')
ylabel('$\tilde{\theta}$')
legend(par1,par2,'Location','SouthEast')

print(path_e0_vs_deltatheta,'-depsc2')

%--------------- Fig5 -------------
figure(5)
clf

h1 = subplot(211);
hold on
plot(t,u_g1)
plot(t,u_g1dz,'Linew',0.5)
grid on
titleStr = strcat('$u$ com $', paramstr, ' = ', num2str(param1), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast')

h2 = subplot(212);
hold on
plot(t,u_g2)
plot(t,u_g2dz,'Linew',0.5)
grid on
titleStr = strcat('$u$ com $', paramstr, ' = ', num2str(param2), '$');
title(titleStr);
legend(par1,par2,'Location','SouthEast')

%Reduce gap btw subplots
pos_pct = .05;
set(h2,'Position',[h2.Position(1), h2.Position(2) + pos_pct*(h1.Position(2) - h2.Position(2)), h2.Position(3), h2.Position(4)]);

print(path_u, '-depsc2')

%--------------------------------------- Impress?o dos diagramas -----
if strcmp(PRINT,'ON')
    open_system('MRAC_111_8_5');
%     print -dpdf -sMRAC_111_8_5 ../relatorio/figs/blocks/MRAC_111_8_5.pdf
    print -depsc2 -sMRAC_111_8_5 ../relatorio/figs/blocks/MRAC_111_8_5.eps
    
    open_system('MRAC_111_8_5/Plant');
%     print -dpdf -sMRAC_111_8_5/Plant ../relatorio/figs//blocks/plant.pdf
    print -depsc2 -sMRAC_111_8_5/Plant ../relatorio/figs//blocks/plant.eps
    
    open_system('MRAC_111_8_5/Reference model');
%     print -dpdf '-sMRAC_111_8_5/Reference model' ../relatorio/figs//blocks/reference-model.pdf
    print -depsc2 '-sMRAC_111_8_5/Reference model' ../relatorio/figs//blocks/reference-model.eps
    
    open_system('MRAC_111_8_5/Adaptation');
%     print -dpdf -sMRAC_111_8_5/Adaptation ../relatorio/figs//blocks/adaptation.pdf
    print -depsc2 -sMRAC_111_8_5/Adaptation ../relatorio/figs//blocks/adaptation.eps
    
    open_system('MRAC_111_8_5/Reference signal');
%     print -dpdf '-sMRAC_111_8_5/Reference signal' ../relatorio/figs//blocks/reference-signal.pdf
    print -depsc2 '-sMRAC_111_8_5/Reference signal' ../relatorio/figs//blocks/reference-signal.eps
    
    close_system('MRAC_111_8_5');
end