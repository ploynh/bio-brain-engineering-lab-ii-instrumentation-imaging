function proj = projection(image, ang, view)
% proj: output projection results (sinogram)
% image: input image
% ang: rotaion angle/angular range
% view: the number of view
    theta = linspace(1, ang, view);
    proj = zeros(size(image, 2), view);
    for i = 1:view
        %%% Write your code using 'imrotate' function
        rot_image = imrotate(image,theta(i),'nearest','crop');
        %%%
        proj(:, i) = sum(rot_image, 1)';
    end
end
