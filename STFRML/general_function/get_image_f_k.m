function image_f_k = get_image_f_k(image)
[m, n] = size(image);
% [image_x, image_y] = gradient(image);
% [image_xx, temp_xy] = gradient(image_x);
% [temp_yx, image_yy] = gradient(image_y);
image_x = x_backward_diff(image);
image_xx = x_forward_diff(image_x);
image_y = y_backward_diff(image);
image_yy = y_forward_diff(image_y);
image_x_abs = abs(image_x);
image_y_abs = abs(image_y);
length_gradient = sqrt(image_x.^2 + image_y.^2);
image_xx_abs = abs(image_xx);
image_yy_abs = abs(image_yy);
x = 1 : n;
% xx = repmat(x, [m, 1]);
y = 1 : m;
% yy = repmat(y' , [1, n]);
[xx,yy]=meshgrid(x,y);

image_f_k = [image, image_x_abs, image_y_abs, length_gradient, image_xx_abs, image_yy_abs];
image_f_k = reshape(image_f_k,[m*n,6]);

% gabor
% options.gabor_mode = 'radial';
% options.gabor_mode = 'oriented';
% options.iscomplex = 1;
% options.ntheta = 8;
% options.nsigma =3;
% options.nfreq = 1;
% options.add_spacial = 0;
% % fprintf('--> Computing Gabor filterings: \n');
% [E,F] = compute_gabor_features(image,options); %%E,F size [m*n,24]
% image_f_k  = [image_f_k, E, F];


% image_f_k = [xx,yy,image, image_x_abs, image_y_abs, length_gradient, image_xx_abs, image_yy_abs];
% image_f_k = reshape(image_f_k,[m,n,8]);
% for i = 1 : m
%     for j = 1 : n
%         image_f_k(i, j, :) = [i, j, image(i, j), image_x_abs(i, j), image_y_abs(i, j), length_gradient(i, j), image_xx_abs(i,j), image_yy_abs(i,j)];
%     end
% end