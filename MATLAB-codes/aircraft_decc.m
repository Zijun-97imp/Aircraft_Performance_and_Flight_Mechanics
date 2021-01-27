% matlab profile for aircraft landing
% for flight decceleration landing

%% input relevant values
A = 19.3;                         % unit: m^2
g = 9.81;                         % unit: m*s^-2
M = 4180;                         % unit: kg
T = 19700;                        % unit: N
Vs = 62;                          % unit: m*s^-1
R = 1.085;                        % unit: kg*m^-3 ISA
miu = 0.02;                       % non unit

H = 15.2;                         % landing height
VA = 68;                       % landing speed - F16 fighter sample

W = M*g;                               % weight
Cls = ((2*W)/(R*(Vs^2)*A));            % stall speed lift coefficient
ClA = ((2*W)/(R*(VA^2)*A));            % approaching speed lift coefficient
dCl = 1.1;                             % maximum lift coefficient increment
Clmin = ClA-dCl;                       % minimum lift coefficient
Cd = 0.0253+0.0610*(ClA)^2;            % drag coefficent with lift
dCd0 = 0.012;                          % maximum drag coefficient increment
D = (0.5)*(Cd)*(VA^2)*(A)*(R);         % drag force calculation

%% Airborne and Trans distance
thetas = abs(D-T)/W;                                    % descending angle
theta  = asin(thetas);                                  % descending angle in sin-value
sumA = (H/(theta))+(((VA^2)*(theta))/(0.4*g));          % Airborne distance i region
sumT = 2*VA;                                            % transition distance

%% Ground roll distance integration
V = 0:0.1:VA;                     % uniform section of velocity
Vq = V.^2;                        % square of each element
Cdmax = Cd+dCd0;                  % maximum drag coefficient
L = (0.5)*(R)*(Vq)*(Cls)*(A);      % lift-force to take off
Dmax = (0.5)*(R)*(Vq)*(Cdmax)*(A);      % drag-force to take off


k = ((9.81*(T-(D+miu*(W-L)))));    % unit distance travel per V^2


i = 1;
sumL = 0;
for i = 1:88
    sumL = sumL+(W/k(i));
end

sumld = sumA+sumT+sumL


















