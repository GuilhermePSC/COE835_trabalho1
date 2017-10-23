%------------------------------------------------ Initialization -----
tfinal = 10;    %Simulation interval
st = 0.05;      %Sample time to workspace

s = tf('s');    %trick!

%---------------------Simulation 1
ap = ap1;
am = am1;
gamma = gamma1;
yp0 = yp01;
af = af1;

%Matching gain
thetas_1 = -ap - am;   %theta*

% Model
m = 1/(s+am);
M = ss(m);

% Plant
p = 1/(s-ap);
P = ss(p);

m_type = 1;
sim('MRAC_111_8_5',tfinal);

yp_11 = yp;   %Save results
e0_11 = e0;
ym_11 = ym;
theta_11 = theta;
u_11 = u;

%with dzeta
m_type = 2;
sim('MRAC_111_8_5',tfinal);

yp_12 = yp;   %Save results
e0_12 = e0;
ym_12 = ym;
theta_12 = theta;
u_12 = u;

%---------------------Simulation 2

ap = ap2;
am = am2;
gamma = gamma2;
yp0 = yp02;
af = af2;

%Matching gain
thetas_2 = -ap - am;   %theta*

% Model
m = 1/(s+am);
M = ss(m);

% Plant
p = 1/(s-ap);
P = ss(p);

m_type = 1;
sim('MRAC_111_8_5',tfinal);

yp_21 = yp;   %Save results
e0_21 = e0;
ym_21 = ym;
theta_21 = theta;
u_21 = u;

%with dzeta
m_type = 2;
sim('MRAC_111_8_5',tfinal);

yp_22 = yp;   %Save results
e0_22 = e0;
ym_22 = ym;
theta_22 = theta;
u_22 = u;

finish = 1;