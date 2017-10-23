%---------------------------------------------------------------------
%  COE-835  Controle adaptativo
%
%  Script para simular exemplo preliminar (exemplo 3)
%
%  Algoritmo : Gradiente
%
%                                                       Ramon R. Costa
%                                                       30/abr/13, Rio
%---------------------------------------------------------------------
clear all;
clc;

%---------------------------------------------------------------------
disp('-------------------------------')
disp('Script para simular Gradiente Normalizado')
disp(' ')
disp('Caso: Planta ............. n = 1')
disp('      Grau relativo ..... n* = 1')
disp('      Parâmetros ........ np = 1')
disp(' ')
disp('Algoritmo: Método indireto')
disp(' ')
disp('-------------------------------')

PRINT = 'OFF';  %'ON' : imprime diagramas
quit = 0;

% --------------- Default Parameters --------------------
ap_default = -2;
am_default = 1;
af_default = 1;
yp0_default = 5;
gamma_default = 2;

%Plant Parameters
ap1 = ap_default;
ap2 = ap_default;

%Reference Model Parameters
am1 = am_default;
am2 = am_default;

%Filter
af1 = af_default;
af2 = af_default;

%Initial condition
yp01  = yp0_default;
yp02 = yp0_default;
ym0  = 0;

%Reference signal parameters
DC = 1;   %Constant
As = 0;   %Sine wave amplitude
ws = 2;  %Frequency

%Adaptation parameters
gamma1 = gamma_default;         %Adaptation gains
gamma2 = gamma_default;
theta0 = 0;       %Adaptation inicial condition
changed = 0;

%--------------------------------------- Impressão dos diagramas -----
if strcmp(PRINT,'ON')
    open_system('MRAC_111_8_5');
    print -depsc2 '-sMRAC_111_8_5' ../../relatorio_indireto/figs/MRAC_indireto111.eps
    
    open_system('MRAC_111_8_5/Plant');
    print -depsc2 '-sMRAC_111_8_5/Plant' ../../relatorio_indireto/figs/plant.eps
    
    open_system('MRAC_111_8_5/Model');
    print -depsc2 '-sMRAC_111_8_5/Model' ../../relatorio_indireto/figs/reference-model.eps
    
    open_system('MRAC_111_8_5/Adaptation');
    print -depsc2 '-sMRAC_111_8_5/Adaptation' ../../relatorio_indireto/figs/adaptation.eps
    
    open_system('MRAC_111_8_5/Adaptation/Normalization');
    print -depsc2 -sMRAC_111_8_5/Adaptation/Normalization ../../relatorio_indireto/figs/normalization.eps
    
    open_system('MRAC_111_8_5/Reference signal');
    print -depsc2 '-sMRAC_111_8_5/Reference signal' ../../relatorio_indireto/figs/reference-signal.eps
    
    open_system('MRAC_111_8_5/Design');
    print -depsc2 '-sMRAC_111_8_5/Design' ../../relatorio_indireto/figs/design.eps
    
    open_system('MRAC_111_8_5/Prediction');
    print -depsc2 '-sMRAC_111_8_5/Prediction' ../../relatorio_indireto/figs/prediction.eps
    
    close_system('MRAC_111_8_5');
end

finish = 0;
evalin('base','app_gradiente')

while ~quit
    
    while ~finish
        pause(1)
    end
    
    if ~quit && finish
        plot_gradiente
    end

    % --------------- Change to Default --------------------
    %Plant Parameters
    ap1 = ap_default;
    ap2 = ap_default;

    %Reference Model Parameters
    am1 = am_default;
    am2 = am_default;

    %Filter
    af1 = af_default;
    af2 = af_default;

    %Initial condition
    yp01  = yp0_default;
    yp02 = yp0_default;
    ym0  = 0;

    %Reference signal parameters
    DC = 1;   %Constant
    As = 0;   %Sine wave amplitude
    ws = 2;  %Frequency

    %Adaptation parameters
    gamma1 = gamma_default;         %Adaptation gains
    gamma2 = gamma_default;
    theta0 = 0;       %Adaptation inicial condition
    changed = 0;
    finish =0;
end