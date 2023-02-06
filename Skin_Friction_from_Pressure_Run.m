
%% This Matlab program extracts a skin friction from a surface pressure field
%% by using the optical flow methodwhen the boundary enstrophy flux (BEF) field is given or modeled. 
%% This program gives a relative or normalized skin friction field, showing the skin friction 
%% topology.  

clear all;
close all;

%% Load surface pressure and BEF files or Images
% I1=load('dp_Falkner_Skan_m0p5_fin_shock.dat');
% bef1=load('bef_Falkner_Skan_m0p5.dat');

% I1=load('dp_Falkner_Skan_m0p5_delta.dat');
% bef1=load('bef_Falkner_Skan_m0p5.dat');

% I1=load('dp_Falkner_Skan_m0p5_hill.dat');
% bef1=load('bef_Falkner_Skan_m0p5.dat');

% I1=load('dp_Falkner_Skan_m0p5_wing_08_Midori_0p5.dat');
% bef1=load('bef_Falkner_Skan_m0p5_Midori.dat');

I1=load('dp_square_junction_masked.dat');
bef1=load('BEF_square_junction_masked.dat');


%% pre-processing of images 
%% scale factor for downsampling
scale_im=0.5;
%% Gaussian filter size
size_filter=1;
%% generate downsampled and fileterd images
[I2,bef2] = pre_processing_a(I1,bef1,scale_im,size_filter);
Is=I2;
bef=bef2;

%% set relevant parameters
%% scaling factor
factor=1;
%% Lagrange multiplier for solving the optical flow equation
lambda=10^(-4);

%% modeling the source term 
f=-factor*bef; 

%% optical flow computation for extracting the skin friction components tor_x and tor_y
[Ix,Iy]=gradient(Is);
[tor_x,tor_y]=Optical_Flow_generic(Ix,Iy,f,lambda);

tor_mag=(tor_x.^2+tor_y.^2).^0.5;

%% plots
Plots_1


% dlmwrite('tor_x_fin_shock.dat',tor_x);
% dlmwrite('tor_y_fin_shock.dat',tor_y);










