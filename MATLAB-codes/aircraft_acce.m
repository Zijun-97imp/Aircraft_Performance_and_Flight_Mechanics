% matlab profile for aircraft takeoff
% for flight acceleration takeoff

%% input relevant values
A = 19.3;                         % unit: m^2
g = 9.81;                         % unit: m*s^-2
M = 5080;                         % unit: kg
T = 19700;                        % unit: N
Vs = 62;                          % unit: m*s^-1
R = 1.085;                        % unit: kg*m^-3 ISA
miu = 0.02;                       % non unit




%% Phase I distance integration
Vr = (1+0.2)*Vs;              % rotation speed
W = M*g;                      % weight of gravity
dCl = 1.1;                    % high-lift device lift coefficient
dCd0 = 0.012;                 % high-lift device drag coeff-zero lift


Cls = ((2*W)/(R*(Vs^2)*A));            % stall speed lift coefficient
Clmin = Cls-dCl;                       % minimum lift coefficient
Cl = ((2*W)/(R*(Vr^2)*A));             % lift coefficient with high lift
Cd = 0.0253+0.0610*(Cl)^2;             % drag coefficent with lift


V = 0:0.1:Vr;                     % uniform section of velocity
Vq = V.^2;                        % square of each element
L = (0.5)*(R)*(Vq)*(Cl)*(A);      % lift-force to take off
D = (0.5)*(R)*(Vq)*(Cd)*(A);      % drag-force to take off


k = ((0.2*9.81*(T-(D+miu*(W-L)))));    % unit distance travel per V^2


i = 1;
sum1 = 0;
for i = 1:745
    sum1 = sum1+(W/k(i));
end

%% Phase II distance integration
n = 1.25;                              % ratio of weight to lift off
Vlof = ((2*n*W)/(R*Cl*A))^0.5;         % lift off velocity

v2 = Vr:0.1:Vlof;                      % uniform section of velocity
Vq2 = v2.^2;
L2 = (0.5)*(R)*(Vq2)*(Cl)*(A);         % lift-force to take off
D2 = (0.5)*(R)*(Vq2)*(Cd)*(A);         % drag-force to take off

k2 = ((0.2*9.81*(T-(D2+miu*(W-L2))))); % unit distance travel per V^2


j = 1;
sum2 = 0;
for i = 1:88
    sum2 = sum2+(W/k2(j));
end

%% Phase III distance calculation
dn = 1.0;                            % increment above
R = ((Vlof^2)/((dn)*g));             % circular path radius
Dlof = 4973.26068;                   % drag-force to take off
thetas = ((T-Dlof)/W);               % climbing angle sin-value
theta = asin(thetas);                % climbing angle
sum3a = R*thetas;                    % phase iii first region distance
h = (0.1*R*(1-cos(theta)));          % vertical distance
sum3b = (10.7-h)/(tan(theta));       % phase iii second region distance


%% General take off distance is
sumtf = sum1+sum2+sum3a+sum3b        % total take off distance
