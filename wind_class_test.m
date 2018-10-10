clear;clc;

%% 
vw= wblrnd(10,2,10000,1); % Generates a vector 
%with 10000 random wind speeds according to a Weibull distribution
hist(vw); % Histogram
wblfit(vw) % Fit of the vector vwto obtain the 
%Weibull distribution parameters

%% 
clear; clc; close all;
load dat1w;v=dat_w+1e-5; %Sum smallnumberto makesurev isnever=0!
p1 = wblfit(v);c=p1(1);k=p1(2);
interval_v= 0.1;
vv=interval_v:interval_v:30;
wf1 = wblpdf(vv,c,k);

[Nv_dist v_dist]=hist(v,vv);
Nv_dist_pu=Nv_dist/(interval_v*sum(Nv_dist));

figure(1);
subplot(2,2,1);
plot(v);xlabel('Sample','FontSize',16);
ylabel('Windspeed','FontSize',16);grid on;
title('Raw data','FontSize',16);

subplot(2,2,2);
hist(v,100);title('Histogram','FontSize',16);

subplot(2,2,[3 4]);
plot(vv,wf1);hold on;plot(v_dist,Nv_dist_pu);
ylabel('Probability function','FontSize',16);
xlabel('Windspeed','FontSize',16);grid on;
legend('Weibull distribution','Rawdata histogram');
title('Weibull distribution and raw data histogram','FontSize',16);


%%
clear all, close all, clc

% 90 meters Ålborg Danmark
c = 5.8
k = 1.69
interval_v= 0.1;
vv=interval_v:interval_v:30;
wf1 = wblpdf(vv,c,k);

%[Nv_dist v_dist]=hist(v,vv);
%Nv_dist_pu=Nv_dist/(interval_v*sum(Nv_dist));

figure(1);
subplot(2,2,1);
plot(wf1);xlabel('Sample','FontSize',16);
ylabel('Windspeed','FontSize',16);grid on;
title('Raw data','FontSize',16);

subplot(2,2,2);
hist(vv,100);title('Histogram','FontSize',16);

subplot(2,2,[3 4]);
plot(vv,wf1);
%hold on;plot(v_dist,Nv_dist_pu);
ylabel('Probability function','FontSize',16);
xlabel('Windspeed','FontSize',16);grid on;
legend('Weibull distribution','Rawdata histogram');
title('Weibull distribution and raw data histogram','FontSize',16);


%% 
clear;clc;close all;
load dat_w2.mat;
% v is at altitude zref
vref=v;
zref=80;z0=2;z=100;
p1 = wblfit(vref) % output c k
c_corr= p1(1) .* log (z/z0) ./ log(zref/z0)
vv= vref.* log (z/z0) ./ log(zref/z0);
% vvisthecorrectedv windspeedvector
p2= wblfit(vv) % Checkthatitworks!