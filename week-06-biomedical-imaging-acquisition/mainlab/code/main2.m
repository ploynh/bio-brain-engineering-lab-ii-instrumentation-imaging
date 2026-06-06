%% Load the given brain image and visualize each coil image

clear; clc;
lab_dir = fileparts(fileparts(mfilename('fullpath')));
brain_img = load(fullfile(lab_dir, '2023_skeleton', 'MR', 'brain_img_main2.mat'));
orig_img1 = brain_img.orig_img(:, :, 1);
orig_img2 = brain_img.orig_img(:, :, 2);
orig_img3 = brain_img.orig_img(:, :, 3);
orig_img4 = brain_img.orig_img(:, :, 4);
orig_img5 = brain_img.orig_img(:, :, 5);

figure(10);
subplot(2, 3, 1)
imagesc(orig_img1), colormap gray;
title('Original image 1')

subplot(2, 3, 2)
imagesc(orig_img2), colormap gray;
title('Original image 2')

subplot(2, 3, 3)
imagesc(orig_img3), colormap gray;
title('Original image 3')

subplot(2, 3, 4)
imagesc(orig_img4), colormap gray;
title('Original image 4')

subplot(2, 3, 5)
imagesc(orig_img5), colormap gray;
title('Original image 5')

%% Make k-space for each coil image

%%% Write your code using 'fft2', 'fftshift' function
orig_kspace1 = fftshift(fft2(orig_img1));
orig_kspace2 = fftshift(fft2(orig_img2));
orig_kspace3 = fftshift(fft2(orig_img3));
orig_kspace4 = fftshift(fft2(orig_img4));
orig_kspace5 = fftshift(fft2(orig_img5));
%%%

figure(11);
subplot(2, 3, 1)
imagesc(log10(abs(orig_kspace1))), colormap gray;
title('Original k-space 1')

subplot(2, 3, 2)
imagesc(log10(abs(orig_kspace2))), colormap gray;
title('Original k-space 2')

subplot(2, 3, 3)
imagesc(log10(abs(orig_kspace3))), colormap gray;
title('Original k-space 3')

subplot(2, 3, 4)
imagesc(log10(abs(orig_kspace4))), colormap gray;
title('Original k-space 4')

subplot(2, 3, 5)
imagesc(log10(abs(orig_kspace5))), colormap gray;
title('Original k-space 5')

%% set downsampling rate as two('DSrate')

DSrate = 8;

%% Make downsampling mask and use it to make downsampled k-space. c.f. using the variable 'DSrate'

%%% Write your code
size_line = size(orig_img1, 1);
DS_mask = zeros(size_line, 1);

% Set every DSrate-th index to 1
for i = 1:DSrate:size_line - 1
    DS_mask(i) = 1;
end

DS_mask = repmat(DS_mask, 1, size(orig_img1, 2));
%%%

DS_kspace1 = orig_kspace1 .* DS_mask;
DS_kspace2 = orig_kspace2 .* DS_mask;
DS_kspace3 = orig_kspace3 .* DS_mask;
DS_kspace4 = orig_kspace4 .* DS_mask;
DS_kspace5 = orig_kspace5 .* DS_mask;

figure(12);
subplot(2, 3, 1)
imagesc(log10(abs(DS_kspace1))), colormap gray;
title('Downsampled k-space 1')

subplot(2, 3, 2)
imagesc(log10(abs(DS_kspace2))), colormap gray;
title('Downsampled k-space 2')

subplot(2, 3, 3)
imagesc(log10(abs(DS_kspace3))), colormap gray;
title('Downsampled k-space 3')

subplot(2, 3, 4)
imagesc(log10(abs(DS_kspace4))), colormap gray;
title('Downsampled k-space 4')

subplot(2, 3, 5)
imagesc(log10(abs(DS_kspace5))), colormap gray;
title('Downsampled k-space 5')
%% Check the downsampled image using inverse Fourier transform

%%% Write your code using 'ifft2', 'ifftshift', 'abs' function
DS_img1 = abs(ifft2(ifftshift(DS_kspace1)));
DS_img2 = abs(ifft2(ifftshift(DS_kspace2)));
DS_img3 = abs(ifft2(ifftshift(DS_kspace3)));
DS_img4 = abs(ifft2(ifftshift(DS_kspace4)));
DS_img5 = abs(ifft2(ifftshift(DS_kspace5)));
%%%

figure(13);
subplot(2, 3, 1)
imagesc(DS_img1), colormap gray;
title('Downsampled image 1')

subplot(2, 3, 2)
imagesc(DS_img2), colormap gray;
title('Downsampled image 2')

subplot(2, 3, 3)
imagesc(DS_img3), colormap gray;
title('Downsampled image 3')

subplot(2, 3, 4)
imagesc(DS_img4), colormap gray;
title('Downsampled image 4')

subplot(2, 3, 5)
imagesc(DS_img5), colormap gray;
title('Downsampled image 5')

%% Load the coil sensitivity map data

coil_sensitivity_map = load(fullfile(lab_dir, '2023_skeleton', 'MR', 'coil_sensitivity_map.mat'));
coil_map1 = coil_sensitivity_map.coil_map(:, :, 1);
coil_map2 = coil_sensitivity_map.coil_map(:, :, 2);
coil_map3 = coil_sensitivity_map.coil_map(:, :, 3);
coil_map4 = coil_sensitivity_map.coil_map(:, :, 4);
coil_map5 = coil_sensitivity_map.coil_map(:, :, 5);

figure(14);
subplot(2, 3, 1)
imagesc(coil_map1), colormap gray;
title('Coil map 1')

subplot(2, 3, 2)
imagesc(coil_map2), colormap gray;
title('Coil map 2')

subplot(2, 3, 3)
imagesc(coil_map3), colormap gray;
title('Coil map 3')

subplot(2, 3, 4)
imagesc(coil_map4), colormap gray;
title('Coil map 4')

subplot(2, 3, 5)
imagesc(coil_map5), colormap gray;
title('Coil map 5')

%% Get the reconstruction image from aliased images using SENSE_reconstruction.m

DS_img = cat(3, DS_img1, DS_img2, DS_img3, DS_img4, DS_img5);
coil_map = coil_sensitivity_map.coil_map;
recon_img = SENSE_reconstruction(DS_img, coil_map, DSrate);

figure(15);
imagesc(recon_img), colormap gray;
title(sprintf('DSrate = %d', DSrate));
%% Repeats the experiments with the various DSrates and find the limits of downsampling rate
set_of_DSrate = [2,3,4,6,8];
