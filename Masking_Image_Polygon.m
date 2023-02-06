
%% This program masks a data file or image file by selecting a polygon region.  

clear all
close all

%% read data file or image file
% read image
%I=imread('PM055P100_I13I14_a.tif');
%I=rgb2gray(I(:,:,1:3));
%I=double(I);

I=load('dp_Falkner_Skan_m0p5_fin_shock.dat');

figure(1);
imagesc(I);
colormap(gray);
axis('image');
colorbar;


%% select a polygon region using a masking function
%% generate the masked image or data 'I_masked' and the mask 'BW'
%% undex_mask=1: inner mask, inex_mask=0: outer mask

NumPoints=4; % number of selected points
value_background=0;
index_mask=0;
[I_masked,BW]=masking_image_region_fun(I,NumPoints,value_background,index_mask);

Is=I_masked;

figure(1);
imagesc(Is);
colormap(gray);
axis('image');
xlabel('x (pixel)');
ylabel('y (pixel)');
title('Masked Image');

% imwrite(uint8(Is),'double_delta_LaRC_masked.tif');
% imwrite(uint8(BW),'BW_double_delta_LaRC.tif');




