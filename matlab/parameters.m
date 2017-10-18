%% Default parameters

%------------------------------------ Simulation time parameters -----

tfinal = 10;    %Simulation interval
st = 0.05;      %Sample time to workspace

%----------------------------------- Reference signal parameters -----
DC = 1;   %Constant
As = 0;   %Sine wave amplitude
ws = 10;  %Frequency

%---------------------------------------------- Plant parameters -----
ap = -2;
am = 1;
yp0  = 0;
ym0  = 0;

%----------------------------------------- Adaptation parameters -----
gamma = 10;       %Adaptation gains
theta0 = 0;       %Adaptation inicial condition
af = 1;

%% Alternative parameters

%---------------------------------------------- Plant parameters -----
ap_2 = -5;
am_2 = 10;
yp0_2  = 2;
yp0_3  = -2;
ym0_2  = 0;

%----------------------------------------- Adaptation parameters -----
gamma_2 = 100;       %Adaptation gains
theta0_2 = 0;       %Adaptation inicial condition
af_2 = 10;