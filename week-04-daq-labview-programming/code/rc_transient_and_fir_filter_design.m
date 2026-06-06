clear;
clc;
close all;

%% 13
syms s t f R1 Vm Ce
% Ce = sym(1);
% Vm = sym(1);
% f = sym(1);
% R1 = sym(1);
% t = sym('t');

Vin_t = Vm*(cos(2*pi*f*t));
Vin_s = laplace(Vin_t, t, s)
I_s = Vin_s*(1/(R1 + 1/(s*Ce)))
I_t = ilaplace(I_s, s, t)
Vout_s = I_s*(1/(s*Ce))
Vout_t = ilaplace(Vout_s, s, t)

% figure;
% fplot(I_t, [0, 3], 'b-');
% hold on;
% fplot(Vout_t, [0, 3], 'r-'); 
% 
% xlabel('Time (s)');
% ylabel('Current (A) and Voltage (V)');
% legend('Current', 'Voltage');

%% 14
Ce = 1;
Vm = 1;
R1 = 1;
t = linspace(0, 10, 1000);

I_t = (Vm/R1)*exp(-t/(R1*Ce));
Vout_t = Vm*(1 - exp(-t/(R1*Ce)));

figure;
plot(t, I_t, 'b-');
hold on;
plot(t, Vout_t, 'r-');
xlabel ('Time (s)');
ylabel ('Current (A) and Voltage (V)');
legend ('Current', 'Voltage');