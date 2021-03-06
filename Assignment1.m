clear all, close all, clc

% Assignment 1


%% Setup
% Wind farm location: Sweden? India?
% E	8.31 freq	5.66 m/s	5.44 potencia	
% Weibull C 6.54	Weibull K 1.895
% link: http://atlaseolico.idae.es/meteosim/ 

c = 6.54; %value from farm
k = 1.895
z = 60; % depends on the tower height
z0 = 0.001; %value from farm
zref = 80; %from a specific country? 80 for spain
% 

c_prime = c * log(z/z0)/log(zref/z0)

%% Available energy generated

rho=1.225; %Air density kg/m3 change?
Cp = 0.4; %power coefficient
D = 100; %rotor diameter
A = 0.25*pi*D^2;
Pnom = 2.5e6; % change depending on the limit of the turbine

interval_v= 1;
vv=0:interval_v:20;
wf1 = wblpdf(vv,c_prime,k);


figure(1);
plot(wf1);xlabel('Sample','FontSize',16);
ylabel('Windspeed','FontSize',16);grid on;
title('Raw data','FontSize',16);
%hist(vw); % Histogram

power = [];
power_curt = [];

vv_lowlim = 0:interval_v:20; %%% add lower boundary to "turn on"


power = 0.5 * rho * A * Cp * vv.^3; % not curtailed
power_curt = min (Pnom , 0.5 * rho * A * Cp * vv.^3); % curtailed with nominal Power

figure(2);
plot(vv,power,vv,power_curt);
xlabel('Sample','FontSize',16);
ylabel('Power','FontSize',16);grid on;
title('Raw data','FontSize',16);
%add power curve from manufacturer?
%% Energy

tot_hour = 24*365; 

E = tot_hour*wf1.*power;
E_curt = tot_hour*wf1.*power_curt;

figure(3);
plot(vv,E,vv,E_curt);
xlabel('Sample','FontSize',16);
ylabel('Energy','FontSize',16);grid on;
title('Raw data','FontSize',16);


op_years = 20; % years in operation
% annual energy production (AEP)
AEP_curt = sum(E_curt);

% calculate capacity factor 
CF = AEP_curt / (Pnom * tot_hour) % Capacity factor


% calculate total energy generated over op_years
AEP_tot20 = op_years*AEP_curt;

%% Price and income

%estimate market price
el_price = 20:-0.5:10; % euro per MWh
MW = 1e6;

tot_income_year = el_price .* AEP_curt/MW; %to plot the falling income
tot_income = sum(tot_income_year); % in euros

% cost of turbine for a certain benefit
invest = tot_income; % minus some profit I guess

% interest 
invest1 = invest/1.01^20;
invest3 = tot_income/1.03^20;
invest5 = invest/1.05^20;
invest7 = invest/1.07^20;

%% Turbine cost analysis

% Estimate the cost the wind turbine
COST = 0.67 *Pnom^0.81 + 2502*D^0.92%(assuming onshore)
%The cost model is only an example for the assignment, it is not a validated cost function
%P: Wind turbine power (W)
%D: Rotor diameter (m)
%Calculate the LCOE.

% NOT FINISHED, ONLY GUESSED
CAPEX = COST %choose investment size
OPEX = 1000 % set some cost for the year
FIN = 1%financial cost
AEP = AEP_curt;
N = op_years; % economic lifetime
LCOE = ((CAPEX + FIN)/N + OPEX)/AEP

%Analyze the influence of all the parameters of the wind turbine (length of blades, power rating, hub height, �)