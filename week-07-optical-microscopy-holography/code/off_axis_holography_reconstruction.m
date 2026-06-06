% Off-axis holography reconstruction workflow.

%% Initialization

clc; clear; close all;

%% Task 1 :: Load the Captured Image;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load your own image that you captured in off-axis holography and display it
% Set the colormap of image to gray and display the colorbar

lab_dir = fileparts(fileparts(mfilename('fullpath')));
default_file = fullfile(lab_dir, 'data', 'off_axis_hologram_sample.mat');
[filenames,path] = uigetfile(default_file, 'MultiSelect', 'off');
image = importdata(fullfile(path,filenames));

figure(1); axis image;
imagesc(image); colormap gray; colorbar;
title('Raw Image');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 2 :: Implement Experimental Parameters & Camera Specification

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fill out the blank for experimental conditions
% Writing a memo during experiment is recommended

% Experimental Parameters
wavelength = 532*(10^(-9)); % 532 nm
NA = 0.1; % 0.1
magnification = 180/45; % 4f system with focal length of lens 45 mm & 180 mm

% Camera Specification
pixel_size = 3.45e-6;
pixel_number_x = size(image,2);
pixel_number_y = size(image,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 3 :: Transform the Image to k-space

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implement 2D Fourier transform
% Use 'fft2' and 'fftshift' function
% Display the magnitude of k-space in log scale. Set the colormap of image to jet and display the colorbar

image_FFT = fftshift(fft2(image));

figure(2); axis image;
imagesc(log10(abs(image_FFT))), colormap jet; colorbar;
title ('k-space');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 4 :: Find Center of the Image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find the center of the k-space using pixel_number_x and pixel_number_y
% Center is used to find the FFT(O(r)R(r)*), and to shift it to the centerma

center_x = pixel_number_x / 2;
center_y = pixel_number_y / 2;
center_position = [center_x, center_y];

viscircles(center_position,20); % Visualize the center in k-space image. Utilize to check your code.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 5 :: Find Peak of FFT(O(r)R(r)*)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Find the center (peak) of the O(r)R(r)* located on the bottom left of the center
% Restrict the acceptable peak-to-peak separation from the center to improve finding the peak

peak_index = maxk(max(image_FFT),100,'ComparisonMethod','abs'); % Find maximum magnitude of each complex vector in k-space

findPeak = false; % true when the peak found, false when the peak still have to find
MinPeakDistance = 600; % Set your own value. Minimum peak-to-peak separartion (Refer the image)

i = 1;
while ~findPeak && i <= length(peak_index)
    [peak_y, peak_x] = find(ismember(image_FFT, peak_index(i))); % Find each indices of the maxima during iteration
    peak_position = [peak_x peak_y];

    %%%%%% Implement Your Code %%%%%%
    % Condition 1 :: Peak has to farther away from the center than MinPeakDistance
    % Condition 2 :: Peak will be located on the bottom left of the center
    if norm(peak_position - center_position) > MinPeakDistance && peak_x < center_x && peak_y > center_y
        findPeak = true;
        viscircles(peak_position,10); % Visualize the center of FFT(O(r)R(r)*. Utilize to check your code.
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    i = i + 1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 6 :: Crop FFT(O(r)R(r)*) from the Image

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the right value of the radius based on the concept of k-space
% Make a circular mask, which center is 'peak_position' and radius is 'radius_NA_circle' using 'meshgrid' function
% 	
% Display the magnitude of k-space in log scale. Set the colormap of image to jet and display the colorbar

radius_NA_circle = NA*pixel_size*pixel_number_y/wavelength/magnification;

mask = zeros(pixel_number_y,pixel_number_x);

col = -(peak_y-1):(pixel_number_y - peak_y);
row = -(peak_x-1):(pixel_number_x - peak_x);

[X,Y] = meshgrid(row,col);

%%%%%% Implement Your Code %%%%%%
mask((X.^2 + Y.^2) <= radius_NA_circle^2) = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

image_FFT_crop = image_FFT .* mask;

figure(3); axis image;
imagesc(log(abs(image_FFT_crop))); colormap jet; colorbar;
title('Masked Magnitude of k-space');

viscircles(peak_position,20); % Utilze to check your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 7 :: Shift the NA Circle to the Center of the k-space

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the distance that NA circle have to shift to align on the center
% Use 'circshift' function to shift the image to the center
% Display the magnitude of k-space in log scale. Set the colormap of image to jet and display the colorbar

distance_x = center_x - peak_x;
distance_y = center_y - peak_y;
image_FFT_crop_shift = circshift(image_FFT_crop, [distance_y, distance_x]);

figure(4); axis image;
imagesc(log(abs(image_FFT_crop_shift))); colormap jet; colorbar;
title('Masked and Shifted Magnitude of k-space');

viscircles(center_position,20); % Utilze to check your code

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Task 8 :: Image Reconstruction

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Implement 2D Inverse Fourier transform to reconstruct the image
% Use 'ifft2' and 'ifftshift' function
% Display the reconstructed intensity and phase image. (Use 'angle' to get phase information)
% Set the colormap of image to gray and jet, respectively and display the colorbar

image_recon = ifft2(ifftshift(image_FFT_crop_shift));

amp_image_recon = abs(image_recon);
intensity_image_recon = amp_image_recon.^2;
phase_image_recon = angle(image_recon);

figure(5); axis image;
imagesc(intensity_image_recon); colormap gray; colorbar;
title("Reconstructed Intensity");

figure(6); axis image;
imagesc(phase_image_recon); colormap jet; colorbar;
title("Reconstructed Phase");

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
