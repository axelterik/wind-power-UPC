clear all, close all, clc

% Assignment 1


%% Setup
% Wind farm location: Sweden? India?

% c = value from farm
% z = value from farm
% z0 = value from farm
% zref = from a specific country? 80 for spain
% 

c_prime = c * ln(z/z0)/ln(zref/z0)

%% Available energy generated

op_years = 20 % years in operation
air_dens = %something
Cp = %power coefficient
rot_diam = 50 %rotor diameter

%add power curve from manufacturer?

% calculate total energy generated over op_years
% and annual energy production (AEP)
% calculate capacity factor 
