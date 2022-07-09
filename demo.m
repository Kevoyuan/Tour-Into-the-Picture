clear; close all; clc;

% Inputs
L1x = [1 3]; 
L1y = [2 4];
L2x = [1 3]; 
L2y = [4 3];
showIntersectionPlot = 1;

% Function callback
[xi,yi] = linexline(L1x, L1y, L2x, L2y, showIntersectionPlot);
 

