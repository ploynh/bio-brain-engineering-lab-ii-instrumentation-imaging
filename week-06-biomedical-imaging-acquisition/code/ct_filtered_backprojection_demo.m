%% Load the phantom image (512 x 512)
% pht: CT image

clear; clc;
lab_dir = fileparts(fileparts(mfilename('fullpath')));
% Requires the course-provided CT phantom .mat file, which is not published.
obj2d_ori = load(fullfile(lab_dir, '2023_skeleton', 'CT', 'obj2d_ori.mat'));
pht = obj2d_ori.obj2d_ori;

figure(10);
imagesc(pht), colormap gray;
title('Phantom image');
%% Make a projection
% ang: angular range
% views: the number of projection views
% proj: sinogram

ang = 180;
view = 90;
proj = projection(pht, ang, view);

figure(11);
imagesc(proj), colormap gray;
title(sprintf('Sinogram (ang=%d, view=%d)', ang, view));
%% Apply 'ramp filter' for each projection in Fourier domain
% flt: ramp filter
% flt_proj: filtered sinogram

flt = abs(linspace(-1, 1, size(proj, 1)))';
flt = repmat(flt, 1, size(proj, 2));

figure(12);
imagesc(flt), colormap gray;
title('Ramp filter');
%%
%%% Write your code using 'fft2', 'fftshift', 'ifft2', 'ifftshift', 'real' function
b4flt_proj = fftshift(fft2(proj));
flt_proj = real(ifft2(ifftshift(b4flt_proj .* flt))) ;
%%%

figure(13);
imagesc(flt_proj), colormap gray;
title(sprintf('Filtered sinogram (ang=%d, view=%d)', ang, view));
%% Make a back-projection
% recon: reconstructed CT image

recon = backprojection(flt_proj, ang, view);
figure(14);
imagesc(recon), colormap gray;
title(sprintf('Reconstructed CT image (ang=%d, view=%d)', ang, view));
%% Repeat projection / back-projection with various condition
% filtered / non-filtered sinogram
% ang = 60, 90, 180 (fix view = 180)
% view = 60, 90, 180 (fix ang = 180)


