function image_out  = genCircle(image,w,r)
%GENCIRCLE Summary of this function goes here
%   Detailed explanation goes here
%   w image's size
%   r mask's radius
[rr cc] = meshgrid(1:w);
c = sqrt((rr-floor(w/2)).^2 + (cc-floor(w/2)).^2) <= r;%roi的点位置为1，roi以外的点位置为0
image_out = c.*image;
