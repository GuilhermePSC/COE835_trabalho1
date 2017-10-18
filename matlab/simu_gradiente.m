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

%--------------------------------- Simulation 1: gamma variation -----

run parameters.m;
paramstr = '\gamma';
param1 = gamma;
param2 = gamma_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1 = yp;   %Save results
e0_g1 = e0;
theta_g1 = theta;
u_g1 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1dz = yp;   %Save results
e0_g1dz = e0;
theta_g1dz = theta;
u_g1dz = u;

%-----------------------------

gamma = gamma_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2 = yp;   %Save results
e0_g2 = e0;
theta_g2 = theta;
u_g2 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2dz = yp;   %Save results
e0_g2dz = e0;
theta_g2dz = theta;
u_g2dz = u;

%Print plots
name = strcat('gamma','_',num2str(param1),'_',num2str(param2));
PRINT = 'ON';  %'ON' : imprime diagramas do simulink
run print_plots.m

%----------------------------------- Simulation 2: yp0 variation -----

run parameters.m;
paramstr = 'y_p(0)';
param1 = yp0;
param2 = yp0_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1 = yp;   %Save results
e0_g1 = e0;
theta_g1 = theta;
u_g1 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1dz = yp;   %Save results
e0_g1dz = e0;
theta_g1dz = theta;
u_g1dz = u;

%-----------------------------

yp0 = yp0_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2 = yp;   %Save results
e0_g2 = e0;
theta_g2 = theta;
u_g2 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2dz = yp;   %Save results
e0_g2dz = e0;
theta_g2dz = theta;
u_g2dz = u;

%Print plots
name = strcat('yp0','_',num2str(param1),'_',num2str(param2));
PRINT = 'OFF';  %'ON' : imprime diagramas do simulink
run print_plots.m

%----------------------------------- Simulation 3: yp0 variation -----

run parameters.m;
paramstr = 'y_p(0)';
param1 = yp0;
param2 = yp0_3;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1 = yp;   %Save results
e0_g1 = e0;
theta_g1 = theta;
u_g1 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1dz = yp;   %Save results
e0_g1dz = e0;
theta_g1dz = theta;
u_g1dz = u;

%-----------------------------

yp0 = yp0_3;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2 = yp;   %Save results
e0_g2 = e0;
theta_g2 = theta;
u_g2 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2dz = yp;   %Save results
e0_g2dz = e0;
theta_g2dz = theta;
u_g2dz = u;

%Print plots
name = strcat('yp0','_',num2str(param1),'_',num2str(param2));
PRINT = 'OFF';  %'ON' : imprime diagramas do simulink
run print_plots.m

%----------------------------------- Simulation 4: ap variation -----

run parameters.m;
paramstr = 'a_p';
param1 = ap;
param2 = ap_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1 = yp;   %Save results
e0_g1 = e0;
theta_g1 = theta;
u_g1 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1dz = yp;   %Save results
e0_g1dz = e0;
theta_g1dz = theta;
u_g1dz = u;

%-----------------------------

ap = ap_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2 = yp;   %Save results
e0_g2 = e0;
theta_g2 = theta;
u_g2 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2dz = yp;   %Save results
e0_g2dz = e0;
theta_g2dz = theta;
u_g2dz = u;

%Print plots
name = strcat('ap','_',num2str(param1),'_',num2str(param2));
PRINT = 'OFF';  %'ON' : imprime diagramas do simulink
run print_plots.m

%----------------------------------- Simulation 5: am variation -----

run parameters.m;
paramstr = 'a_m';
param1 = am;
param2 = am_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1 = yp;   %Save results
e0_g1 = e0;
theta_g1 = theta;
u_g1 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1dz = yp;   %Save results
e0_g1dz = e0;
theta_g1dz = theta;
u_g1dz = u;

%-----------------------------

am = am_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2 = yp;   %Save results
e0_g2 = e0;
theta_g2 = theta;
u_g2 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2dz = yp;   %Save results
e0_g2dz = e0;
theta_g2dz = theta;
u_g2dz = u;

%Print plots
name = strcat('am','_',num2str(param1),'_',num2str(param2));
PRINT = 'OFF';  %'ON' : imprime diagramas do simulink
run print_plots.m

%----------------------------------- Simulation 5: af variation -----

run parameters.m;
paramstr = 'a_f';
param1 = af;
param2 = af_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1 = yp;   %Save results
e0_g1 = e0;
theta_g1 = theta;
u_g1 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g1dz = yp;   %Save results
e0_g1dz = e0;
theta_g1dz = theta;
u_g1dz = u;

%-----------------------------

af = af_2;
run set_model.m;

m_type = 1; %without dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2 = yp;   %Save results
e0_g2 = e0;
theta_g2 = theta;
u_g2 = u;

m_type = 2; %with dotzeta
sim('MRAC_111_8_5',tfinal);
yp_g2dz = yp;   %Save results
e0_g2dz = e0;
theta_g2dz = theta;
u_g2dz = u;

%Print plots
name = strcat('af','_',num2str(param1),'_',num2str(param2));
PRINT = 'OFF';  %'ON' : imprime diagramas do simulink
run print_plots.m
