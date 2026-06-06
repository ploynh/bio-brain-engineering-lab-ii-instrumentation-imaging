clear; clc;
close all;
%%
freq = [1,5,25,50,100,500,2500];
first_in = [1.13, 1.13, 1.13, 1.13, 1.01, 1.01, 1.01];
first_out = [2.09, 2.09, 1.85, 1.45, 0.88, 0.21, 0.06];
first_phase = [1.83, 6.04, 28.2, 46.31, 64.95, 86.0, 94.3];

second_in =[1.07, 1.09, 1.09, 1.07,1.01, 1.01, 1.01];
second_out =[1.71, 1.71, 1.63, 1.13, 0.37, 0.04, 0,03];
second_phase =[2.07, 8.34, 46.41, 95.91, 139.16, 180, 180];
%%
%Magnitude dB = 20log(out/in)
first_mag = [];
second_mag = [];
for i = (1:7)
    stmag = 20*log(first_out(1,i)/ first_in(1,i));
    first_mag = [first_mag; stmag];
    ndmag = 20*log(second_out(1,i)/ second_in(1,i));
    if ndmag == -Inf
        ndmag = -70;
    end
    second_mag = [second_mag; ndmag];
end
%%
figure;
subplot(2, 1, 1);
plot(freq, first_mag);
title('Magnitude');
xlabel('Frequency (Hz)');
ylabel('Maginitude (dB)');

subplot(2, 1, 2);
plot(freq, first_phase);
title('Phase');
xlabel('Frequency (Hz)');
ylabel('Phase (Degree)');

sgtitle('Bode Plote of 1^s^t order low pass filter')
%%
figure;
subplot(2, 1, 1);
plot(freq, second_mag);
title('Magnitude');
xlabel('Frequency (Hz)');
ylabel('Maginitude (dB)');

subplot(2, 1, 2);
plot(freq, second_phase);
title('Phase');
xlabel('Frequency (Hz)');
ylabel('Phase (Degree)');

sgtitle('Bode Plote of 2^n^d order low pass filter')