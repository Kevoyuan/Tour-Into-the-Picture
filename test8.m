% Exercise 2.1 Order of Convergence
clear
close
clc
% Define Variables
F = 12;
x_old = 0;
itr = 0;
epsilon_new = 1e30;
epsilon_target = 1e-6;
while epsilon_new > epsilon_target
    itr = itr+1;
   
    x_new = springcalc(F, x_old);
    epsilon_new = abs(x_new - x_old);
    epsilon(itr)=epsilon_new;
    x_old = x_new;  
end
semilogy(1:length(epsilon), epsilon);

function [x_new] = springcalc(F, x_old)
k_0 = 30;
x_new = F/(k_0*(1+x_old^(0.1)));
end