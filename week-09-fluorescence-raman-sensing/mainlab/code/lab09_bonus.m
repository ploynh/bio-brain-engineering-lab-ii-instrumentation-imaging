clc;
close all;
script_dir = fileparts(mfilename('fullpath'));
r6g_dir = fullfile(fileparts(script_dir), 'data', 'lab9_R6G');

% tasks 8.1
figure
hold on
ref = readmatrix(fullfile(r6g_dir, 'Tue_Group7_ref.csv'));
ref(end, :) = [];
ref(1, :) = [];

sample = readmatrix(fullfile(r6g_dir, 'Tue_Group7_unknown.csv'));
sample(end, :) = [];
sample(1, :) = [];
sample(:, 1) = 1e7./638 - 1e7./sample(:, 1);
sample(:, 2) = sample(:, 2) - ref(:, 2);
ind = sample(:, 1) > 400 & sample(:, 1) < 2500;
c = sample(ind, 1:2);

[local_minima, min_locations] = islocalmin(c(:, 2), 'MinProminence', 10);
minima_values = c(local_minima, 2);
minima_wavelengths = c(local_minima, 1);
baseline1 = interp1(minima_wavelengths, minima_values, c(:, 1), 'pchip');
for i = 1:length(baseline1)
    if c(i, 2) < baseline1(i)
        baseline1(i) = c(i, 2);
    end
end 

plot(sample(ind, 1), sample(ind, 2), 'black', sample(ind, 1), baseline1, 'r--')
hold off
legend('Unknown Sample', 'Baseline')
xlim([400 2500])
xlabel('Wavenumber (cm^{-1})')
ylabel('Intensity (a.u.)')

% task 8.2
figure
plot(sample(ind, 1), sample(ind, 2) - baseline1, 'black')
legend('Unknown Sample')
xlim([400 2500])
xlabel('Wavenumber (cm^{-1})')
ylabel('Intensity (a.u.)')
