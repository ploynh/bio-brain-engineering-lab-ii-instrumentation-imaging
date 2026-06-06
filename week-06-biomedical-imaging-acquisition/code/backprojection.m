function recon = backprojection(proj, ang, view)
% recon: output back-projection results (reconstructed CT image)
% proj: input sinogram
% ang: rotaion angle/angular range
% view: the number of view
    theta = linspace(1, ang, view);
    recon = zeros(size(proj, 1));
    
    for i = 1:view
        temp = repmat(proj(:, i)', size(proj, 1), 1);
        %%% Write your code using 'imrotate' function
        rot_temp = imrotate(temp, -theta(i) ,'nearest','crop');
        %%%
        recon = recon + rot_temp;
    end
end
