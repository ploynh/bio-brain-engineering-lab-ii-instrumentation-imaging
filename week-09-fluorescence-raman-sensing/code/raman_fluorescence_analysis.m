clc;
close all;
%%
script_dir = fileparts(mfilename('fullpath'));
lab_dir = fileparts(script_dir);
r6g_dir = fullfile(lab_dir, 'data', 'raman_spectra');
fluorescence_dir = fullfile(lab_dir, 'data', 'fluorescence_images');

% tasks 1 and 2
figure
hold on
ref = readmatrix(fullfile(r6g_dir, 'r6g_reference.csv'));
ref(end, :) = [];
ref(1, :) = [];

ch1 = readmatrix(fullfile(r6g_dir, 'channel_1.csv'));
ch1(end, :) = [];
ch1(1, :) = [];
ch1(:, 1) = 1e7./638 - 1e7./ch1(:, 1);
ch1(:, 2) = ch1(:, 2) - ref(:, 2);
ind = ch1(:, 1) > 400 & ch1(:, 1) < 2500;
c = ch1(ind, 1:2);

[local_minima, min_locations] = islocalmin(c(:, 2));
minima_values = c(local_minima, 2);
minima_wavelengths = c(local_minima, 1);
baseline1 = interp1(minima_wavelengths, minima_values, c(:, 1), 'pchip');
for i = 1:length(baseline1)
    if c(i, 2) < baseline1(i)
        baseline1(i) = c(i, 2);
    end
end
plot(ch1(ind, 1), ch1(ind, 2), 'r', ch1(ind, 1), baseline1, 'r--')

ch2 = readmatrix(fullfile(r6g_dir, 'channel_2.csv'));
ch2(end, :) = [];
ch2(1, :) = [];
ch2(:, 1) = 1e7./638 - 1e7./ch2(:, 1);
ch2(:, 2) = ch2(:, 2) - ref(:, 2);
ind = ch2(:, 1) > 400 & ch2(:, 1) < 2500;
c = ch2(ind, 1:2);

[local_minima, min_locations] = islocalmin(c(:, 2), 'MinProminence', 10);
minima_values = c(local_minima, 2);
minima_wavelengths = c(local_minima, 1);
baseline2 = interp1(minima_wavelengths, minima_values, c(:, 1), 'pchip');
for i = 1:length(baseline2)
    if c(i, 2) < baseline2(i)
        baseline2(i) = c(i, 2);
    end
end
plot(ch2(ind, 1), ch2(ind, 2), 'g', ch2(ind, 1), baseline2, 'g--')

ch3 = readmatrix(fullfile(r6g_dir, 'channel_3.csv'));
ch3(end, :) = [];
ch3(1, :) = [];
ch3(:, 1) = 1e7./638 - 1e7./ch3(:, 1);
ch3(:, 2) = ch3(:, 2) - ref(:, 2);
ind = ch3(:, 1) > 400 & ch3(:, 1) < 2500;
c = ch3(ind, 1:2);

[local_minima, min_locations] = islocalmin(c(:, 2));
minima_values = c(local_minima, 2);
minima_wavelengths = c(local_minima, 1);
baseline3 = interp1(minima_wavelengths, minima_values, c(:, 1), 'pchip');
for i = 1:length(baseline3)
    if c(i, 2) < baseline3(i)
        baseline3(i) = c(i, 2);
    end
end
plot(ch3(ind, 1), ch3(ind, 2), 'b', ch3(ind, 1), baseline3, 'b--')

ch4 = readmatrix(fullfile(r6g_dir, 'channel_4.csv'));
ch4(end, :) = [];
ch4(1, :) = [];
ch4(:, 1) = 1e7./638 - 1e7./ch4(:, 1);
ch4(:, 2) = ch4(:, 2) - ref(:, 2);
ind = ch4(:, 1) > 400 & ch4(:, 1) < 2500;
c = ch4(ind, 1:2);

[local_minima, min_locations] = islocalmin(c(:, 2));
minima_values = c(local_minima, 2);
minima_wavelengths = c(local_minima, 1);
baseline4 = interp1(minima_wavelengths, minima_values, c(:, 1), 'pchip');
for i = 1:length(baseline4)
    if c(i, 2) < baseline4(i)
        baseline4(i) = c(i, 2);
    end
end
plot(ch4(ind, 1), ch4(ind, 2), 'c', ch4(ind, 1), baseline4, 'c--')

ch5 = readmatrix(fullfile(r6g_dir, 'channel_5.csv'));
ch5(end, :) = [];
ch5(1, :) = [];
ch5(:, 1) = 1e7./638 - 1e7./ch5(:, 1);
ch5(:, 2) = ch5(:, 2) - ref(:, 2);
ind = ch5(:, 1) > 400 & ch5(:, 1) < 2500;
c = ch5(ind, 1:2);

[local_minima, min_locations] = islocalmin(c(:, 2));
minima_values = c(local_minima, 2);
minima_wavelengths = c(local_minima, 1);
baseline5 = interp1(minima_wavelengths, minima_values, c(:, 1), 'pchip');
for i = 1:length(baseline5)
    if c(i, 2) < baseline5(i)
        baseline5(i) = c(i, 2);
    end
end
plot(ch5(ind, 1), ch5(ind, 2), 'm', ch5(ind, 1), baseline5, 'm--')

hold off
legend('Ch1', 'Ch1 baseline', 'Ch2', 'Ch2 baseline', 'Ch3', 'Ch3 baseline', 'Ch4', 'Ch4 baseline', 'Ch5', 'Ch5 baseline')
xlim([400 2500])
xlabel('Wavenumber (cm^{-1})')
ylabel('Intensity (a.u.)')
%%
% task 3
figure
hold on
plot(ch1(ind, 1), ch1(ind, 2) - baseline1, 'r')
plot(ch2(ind, 1), ch2(ind, 2) - baseline2, 'g')
plot(ch3(ind, 1), ch3(ind, 2) - baseline3, 'b')
plot(ch4(ind, 1), ch4(ind, 2) - baseline4, 'c')
plot(ch5(ind, 1), ch5(ind, 2) - baseline5, 'm')
hold off
legend('Ch1', 'Ch2', 'Ch3', 'Ch4', 'Ch5')
xlim([400 2500])
xlabel('Wavenumber (cm^{-1})')
ylabel('Intensity (a.u.)')
%%
% tasks 4 and 5
figure
hold on
c1 = ch1(ind, 2) - baseline1;
c2 = ch2(ind, 2) - baseline2;
c3 = ch3(ind, 2) - baseline3;
c4 = ch4(ind, 2) - baseline4;
c5 = ch5(ind, 2) - baseline5;

[pks1, loc1] = findpeaks(c1);
[val1, I1] = maxk(pks1, 5);

for i = 1:5
    l = [c5(loc1(I1(i))) c4(loc1(I1(i))) c3(loc1(I1(i))) c2(loc1(I1(i))) c1(loc1(I1(i)))];
    plot([1 2 3 4 5], l, 'square-')
end

xticks([1 2 3 4 5])
xticklabels({'Ch5', 'Ch4', 'Ch3', 'Ch2', 'Ch1'})
legend('1496 cm^{-1}', '1345 cm^{-1}', '1637 cm^{-1}', '1176 cm^{-1}', '598 cm^{-1}')
xlabel('Channel number')
ylabel('SERS intensity (a.u.)')
xlim([0.5 5.5])
%%
% Task 6
figure
hold on
ch_f = zeros(5,1);
for i = 1:5
    filename = fullfile(fluorescence_dir, sprintf('channel_%d.jpg', i));
    rgb = imread(filename);
    gray = rgb2gray(rgb);
    ch_f(5-i+1) = mean(gray, 'all');
end
ch_f = ch_f ./ max(ch_f);
ch = reshape(1:5, 5,1);
b1 = ch\ch_f;
yCalc = b1 * ch;

plot(ch, ch_f, 'square')
plot(ch, yCalc)
xticks([1 2 3 4 5])
xticklabels({'Ch5', 'Ch4', 'Ch3', 'Ch2', 'Ch1'})
xlabel('Channel number')
ylabel('Fluorescence intensity (a.u.)')
xlim([0.5 5.5])
%%
% Task 7
figure
hold on
x = [c5(loc1(I1(1))) c4(loc1(I1(1))) c3(loc1(I1(1))) c2(loc1(I1(1))) c1(loc1(I1(1)))];
x = reshape(x, 5, 1);
b1 = x\ch_f;
yCalc = b1 * x;

plot(x, ch_f, 'square')
plot(x, yCalc)
xlabel('SERS intensity at 1496 cm^{-1} (a.u.)')
ylabel('Fluorescence intensity (a.u.)')
