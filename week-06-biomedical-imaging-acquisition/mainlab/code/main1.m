%% Load the given brain image

clear; clc;
lab_dir = fileparts(fileparts(mfilename('fullpath')));
brain_img = load(fullfile(lab_dir, '2023_skeleton', 'MR', 'brain_img_main1.mat'));
img = brain_img.img;

figure(10);
imagesc(img), colormap gray;
title('Brain image');
%% Transform the image to k-space

%%% Write your code using 'fft2', 'fftshift' function
k_space = fftshift(fft2(img));
%%%

figure(11);
imagesc(log10(abs(k_space))), colormap gray;
title('k-space');
%% Replace the center of the k-space with zeros, and reconstruct the image by inverse Fourier transform

k_space_center_zero = k_space;
k_space_center_zero(141:180, 141:180) = 0;
%%% Write your code using 'ifft2', 'ifftshift'
%%% After inverse Fourier transform, 'abs' function should be applied
recon_img = abs(ifft2(ifftshift(k_space_center_zero)));
%%%

figure(12);
imagesc(recon_img), colormap gray;
title('Reconstructed image (k-space center=0)');
%% Replace the periphery of the k-space with zeros, and reconstruct the image by inverse Fourier transform

k_space_periphery_zero = zeros(320);
k_space_periphery_zero(141:180, 141:180) = k_space(141:180, 141:180);
%%% Write your code using 'ifft2', 'ifftshift', 'abs'
recon_img = abs(ifft2(ifftshift(k_space_periphery_zero)));
%%%

figure(13);
imagesc(recon_img), colormap gray;
title('Reconstructed image (k-space periphery=0)');
