function [ux_horn,uy_horn]=Optical_Flow_generic(Ix,Iy,F,lambda)


% Horn's solution as an initial approximation of u and v
% D1 = [0, 0, 0; 0,-1,-1;0,1,1]/2;
% 
% Ix = imfilter((I1+I2)/2, D1, 'symmetric',  'same'); 
% Iy = imfilter((I1+I2)/2, D1', 'symmetric',  'same');
It = F;

maxnum_1=500;
tol_1 = 10^(-12);
% lambda = 10;

[u,v] = horn_schunk_estimator(Iy, Ix, It, lambda, tol_1, maxnum_1);
ux_horn = v;
uy_horn = u;





