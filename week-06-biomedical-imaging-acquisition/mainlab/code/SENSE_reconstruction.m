function [recon] = SENSE_reconstruction(input,coil_sens,down)

%%% recon : reconstruction image resolved from aliasing
%%% input : aliased image
%%% coil_sens : coil sensitivity map
%%% down : downsampling rate

[nY nX num_coil] = size(input); % data size
recon = zeros(nY,nX); % image to be reconstructed


for j = 1 : nX
    for i = 1 : nY/down
        
        pixel_alias = squeeze(input(i,j,:)); % aliased pixel values at (i,j)index
        
        mat_sens = zeros(num_coil,down); % coil sensitivity matrix
        
        for k = 1 : num_coil
            for l = 1 : down
                mat_sens(k,l) = coil_sens(mod(i+nY/down*(l-1)-1,nY)+1,j,k);
            end
            
        end
        
       %%
        %%% Write your code using 'pinv' function
        %%% Refer to eqn.(4) of the supplementary material for MRI
        sol = pinv(mat_sens' * mat_sens) * mat_sens' * pixel_alias;
       %%
        
        for k = 1 : down
            recon(mod(i+nY/down*(k-1)-1,nY)+1,j) = sol(k); % assign pixelx values to the right points.
        end
        
    end
end

recon = recon * down;