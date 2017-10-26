%------------------------------------------------ Initialization -----
st = 0.05;      %Sample time to workspace

s = tf('s');    %trick!

%---------------------Simulation 1
ap = ap1;
am = am1;
gamma = gamma1;
yp0 = yp01;
af = af1;
theta0 = theta01;

%Matching gain
thetas_11 = ap + af;
thetas_12 = ap;

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

%---------------------Simulation 2

ap = ap2;
am = am2;
gamma = gamma2;
yp0 = yp02;
af = af2;
theta0 = theta02;

%Matching gain
ks = -ap - am;
thetas_21 = ap + af;
thetas_22 = ap;

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

finish = 1;