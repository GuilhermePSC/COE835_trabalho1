%-------- Print eps plots -----
title0 = '';
changed_str = '';
switch changed
    case 1
        changed_str = 'ap';
        title0 = '$a_p';
    case 2
        changed_str = 'am';
        title0 = '$a_m';
    case 3
        changed_str = 'af';
        title0 = '$a_f';
    case 4
        changed_str = 'gamma';
        title0 = '$\gamma';
    case 5
        changed_str = 'yp0';
        title0 = '$yp_0';
end

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');

par1 = strcat('$m^2 = 1 + \zeta^2$');
par2 = strcat('$m^2 = 1 + \zeta^2 + \dot{\zeta}^2$');

title1 = strcat(' com~ ',title0,'=',num2str(eval(strcat(changed_str,'1'))),'$');
title2 = strcat(' com~ ',title0,'=',num2str(eval(strcat(changed_str,'2'))),'$');
name = strcat(changed_str,num2str(eval(strcat(changed_str,'1'))),changed_str,num2str(eval(strcat(changed_str,'2'))));

path_e0_vs_deltatheta = strcat('../../relatorio_gradiente/figs/e0_vs_deltatheta/',name,'.eps');
path_e0 = strcat('../../relatorio_gradiente/figs/e0/',name,'.eps');
path_theta = strcat('../../relatorio_gradiente/figs/theta/',name,'.eps');
path_u = strcat('../../relatorio_gradiente/figs/u/',name,'.eps');
path_yp = strcat('../../relatorio_gradiente/figs/yp/',name,'.eps');

%--------------- Fig1 -------------
figure(1);
clf;

subplot(211);
plot(t,e0_11,t,e0_12,'Linew',0.5);
grid on;
titleStr = strcat('$e_0$ ', title1);
title(titleStr);
legend(par1,par2,'Location','SouthEast');

subplot(212)
plot(t,e0_21,t,e0_22,'Linew',0.5);
grid on
titleStr = strcat('$e_0$ ', title2);
title(titleStr);
legend(par1,par2,'Location','SouthEast');

if strcmp(PRINT,'ON')
    print(path_e0,'-depsc2')
end

%--------------- Fig2 -------------
deltatheta_11 = theta_11 - thetas_1;
deltatheta_12 = theta_12 - thetas_1;
deltatheta_21 = theta_21 - thetas_2;
deltatheta_22 = theta_22 - thetas_2;
figure(2);
clf;

subplot(121);
hold on
plot(e0_11,deltatheta_11)
plot(e0_12,deltatheta_12)
grid on
%axis equal
titleStr = strcat('$e_0$ vs. $\tilde{\theta}$',title1);
title(titleStr);
xlabel('$e_0$')
ylabel('$\tilde{\theta}$')
legend(par1,par2,'Location','SouthEast')

subplot(122);
hold on
plot(e0_21,deltatheta_21)
plot(e0_22,deltatheta_22)
grid on
%axis equal
titleStr = strcat('$e_0$ vs. $\tilde{\theta}$', title2);
title(titleStr);
xlabel('$e_0$')
ylabel('$\tilde{\theta}$')
legend(par1,par2,'Location','SouthEast')

if strcmp(PRINT,'ON')
    print(path_e0_vs_deltatheta,'-depsc2')
end

%--------------- Fig3 -------------
figure(3);
clf;

Thetas1 = thetas_1*ones(size(t));
Thetas2 = thetas_2*ones(size(t));

subplot(211);
plot(t,theta_11,t,theta_12,t,Thetas1,'Linew',0.5);
grid on;
titleStr = strcat('$\theta$ ', title1);
title(titleStr);
legend(par1,par2,'$\theta$*','Location','SouthEast');

subplot(212)
plot(t,theta_21,t,theta_22,t,Thetas2,'Linew',0.5);
grid on
titleStr = strcat('$\theta$ ', title2);
title(titleStr);
legend(par1,par2,'$\theta$*','Location','SouthEast');

if strcmp(PRINT,'ON')
    print(path_theta,'-depsc2') 
end

%--------------- Fig4 -------------
figure(4);
clf;

subplot(211);
plot(t,ym_11,t,ym_12,t,r,t,yp_11,t,yp_12,'Linew',0.5);
grid on;
titleStr = strcat('$y_m$ ', title1);
title(titleStr);
legend(par1,par2,'r',strcat('$y_p$ para~ ',par1),strcat('$y_p$ para~ ',par2),'Location','SouthEast');

subplot(212)
plot(t,ym_21,t,ym_22,t,r,t,yp_21,t,yp_22,'Linew',0.5);
grid on
titleStr = strcat('$y_m$ ', title2);
title(titleStr);
legend(par1,par2,'r',strcat('$y_p$ para~ ',par1),strcat('$y_p$ para~ ',par2),'Location','SouthEast');

if strcmp(PRINT,'ON')
    print(path_yp,'-depsc2') 
end

%--------------- Fig5 -------------
figure(5)
clf

subplot(211)
hold on
plot(t,u_11)
plot(t,u_12,'Linew',0.5)
grid on
titleStr = strcat('$u$ ',title1);
title(titleStr);
legend(par1,par2,'Location','SouthEast')

subplot(212)
hold on
plot(t,u_21)
plot(t,u_22,'Linew',0.5)
grid on
titleStr = strcat('$u$ ',title2);
title(titleStr);
legend(par1,par2,'Location','SouthEast')

if strcmp(PRINT,'ON')
    print(path_u, '-depsc2')
end

