
%% This Matlab program generates the superposition of the base pressure field and variation
%% The base field is the Falkner-Skan solution.   

clear all;
close all;

%% Load surface pressure and BEF files or Images
% normalized pressure variation
dp=dlmread('p_norm_avg_N3466a.dat');
dp=double(dp);
dp=imrotate(dp,-90);
dpR=(dp-min(min(dp)))./(max(max(dp))-min(min(dp)));
dp=dpR;

% the Falkner-Skan solution as the base filed
bef1=load('bef_Falkner_Skan_m0p5.dat');
p_base1=load('dp_Falkner_Skan_m0p5.dat');

bef1=imresize(bef1,size(dp));
p_base1=imresize(p_base1,size(dp));

%% Superposition of the base-flow pressure and pressure variation
amp=0.3; % amplitude 
p2=p_base1+dp*amp;


figure(1);
imagesc(dp);
colormap('pink');
axis image;
colorbar;
title('Normalized Pressure');
xlabel('x (pixels)');
ylabel('y (pixels)');


figure(2);
imagesc(p_base1);
colormap('pink');
axis image;
colorbar;
title('Base-flow pressure');
xlabel('x (pixels)');
ylabel('y (pixels)');

figure(3);
imagesc(bef1);
colormap('pink');
axis image;
colorbar;
title('Base-flow BEF');
xlabel('x (pixels)');
ylabel('y (pixels)');


figure(4);
imagesc(p2);
colormap('pink');
axis image;
colorbar;
title('Perturbed pressure');
xlabel('x (pixels)');
ylabel('y (pixels)');










