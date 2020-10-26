
addpath(genpath('spice/mice'))
addpath(genpath('spice/kernel_data'))
clc, clear, close all


Som = 0.00059;
SM = 0.0013;
Skep = diag([Sa Se Si SOM Som SM]);

N = 100000;
kep = mvnrnd(kep0,Skep,N);

% figure
% hold on
% plot(kep(:,1),kep(:,2),'.')

rp = kep(:,1).*(1-kep(:,2));
t0 = cspice_str2et(date); %TBD
elts = [rp,kep(:,2:6),t0*ones(N,1),muSun*ones(N,1)];

x0 = cspice_conics(elts',t0*ones(1,N)); x0=x0';

% figure
% axis equal
% plot3(x0(:,1),x0(:,2),x0(:,3),'.')
% grid on

Sx = cov(x0)

% x = mvnrnd(x,Sx,N);

% hold on
% plot3(x(:,1),x(:,2),x(:,3),'.')




