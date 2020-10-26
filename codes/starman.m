
addpath(genpath('spice/mice'))
addpath(genpath('spice/kernel_data'))
clc, clear, close all


cspice_kclear
cspice_furnsh('kernel_201612.txt')

% constants
AU = cspice_convrt(1.0,'AU','km');
secperday = cspice_convrt(1.0,'days','seconds');
muSun = cspice_bodvcd(10,'GM',1);

% STARMAN
% initial values (km,rad)
date = '2018-02-10 00:00';
a = 1.34126487*AU;
e = 0.2648281;
i = 1.09424;
OM = 317.45885;
om = 177.28664;
M = 3.68007;
kep0 = [a e i OM om M];

rp = a*(1-e);
t0 = cspice_str2et(date); %TBD
elts = [rp,kep0(:,2:6),t0,muSun];
x = cspice_conics(elts',t0);
x(1:3)
x(4:6)


% 1-sigma confidence interval (normal)
Sa = 0.000273*AU;
Se = 0.00015;
Si = 0.0007;
SOM = 0.0007;
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




