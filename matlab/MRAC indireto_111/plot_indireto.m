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
        title0 = '$y_p(0)';
    case 6
        changed_str = 'theta0';
        title0 = '$\theta(0)';
end

set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultTextInterpreter','latex');

par1 = strcat('$\theta = a_p$');
par2 = strcat('$\theta = a_p + a_f$');

title1 = strcat(' com~ ',title0,'=',num2str(eval(strcat(changed_str,'1'))),'$');
title2 = strcat(' com~ ',title0,'=',num2str(eval(strcat(changed_str,'2'))),'$');
name = strcat(changed_str,num2str(eval(strcat(changed_str,'1'))),changed_str,num2str(eval(strcat(changed_str,'2'))));

path_e0 = strcat('../../relatorio_indireto/figs/e0/',name,'.eps');
path_epsilon = strcat('../../relatorio_indireto/figs/epsilon/',name,'.eps');
path_theta = strcat('../../relatorio_indireto/figs/theta/',name,'.eps');
path_u = strcat('../../relatorio_indireto/figs/u/',name,'.eps');
path_yp = strcat('../../relatorio_indireto/figs/yp/',name,'.eps');

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

if PRINT
    print(path_e0,'-depsc2') 
end

%--------------- Fig2 -------------
figure(2);
clf;

subplot(211);
plot(t,epsilon_11,t,epsilon_12,'Linew',0.5);
grid on;
titleStr = strcat('$\epsilon$ ', title1);
title(titleStr);
legend(par1,par2,'Location','SouthEast');

subplot(212)
plot(t,epsilon_21,t,epsilon_22,'Linew',0.5);
grid on
titleStr = strcat('$\epsilon$ ', title2);
title(titleStr);
legend(par1,par2,'Location','SouthEast');

if PRINT
    print(path_epsilon,'-depsc2') 
end

%--------------- Fig3 -------------
figure(3);
clf;

Thetas11 = thetas_11*ones(size(t));
Thetas12 = thetas_12*ones(size(t));
Thetas21 = thetas_21*ones(size(t));
Thetas22 = thetas_22*ones(size(t));

subplot(211);
plot(t,theta_11,t,theta_12,t,Thetas11,t,Thetas12,'Linew',0.5);
grid on;
titleStr = strcat('$\theta$ ', title1);
title(titleStr);
legend(par1,par2,'$\theta$*(i)','$\theta$*(ii)','Location','SouthEast');

subplot(212)
plot(t,theta_21,t,theta_22,t,Thetas21,t,Thetas22,'Linew',0.5);
grid on
titleStr = strcat('$\theta$ ', title2);
title(titleStr);
legend(par1,par2,'$\theta$*(i)','$\theta$*(ii)','Location','SouthEast');

if PRINT
    print(path_theta,'-depsc2')
end

%--------------- Fig4 -------------
figure(4);
clf;

subplot(211);
plot(t,yhat_11,t,yhat_12,t,r,t,yp_11,t,yp_12,'Linew',0.5);
grid on;
titleStr = strcat('$\hat{y}$ ', title1);
title(titleStr);
legend(strcat('$y_m$ para~ ',par1),strcat('$y_m$ para~ ',par2),'r',strcat('$y_p$ para~ ',par1),strcat('$y_p$ para~ ',par2),'Location','SouthEast');

subplot(212)
plot(t,yhat_21,t,yhat_22,t,r,t,yp_21,t,yp_22,'Linew',0.5);
grid on
titleStr = strcat('$\hat{y}$ ', title2);
title(titleStr);
legend(strcat('$y_m$ para~ ',par1),strcat('$y_m$ para~ ',par2),'r',strcat('$y_p$ para~ ',par1),strcat('$y_p$ para~ ',par2),'Location','SouthEast');

if PRINT
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

if PRINT
    print(path_u, '-depsc2')
end
