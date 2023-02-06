
%% generate the base flow with the power-laer distributions of 
%% surface pressure, skin friction and BEF

clear all;
close all;
%% generate the x-coordinate
b1=-100;
b2=100;
NN=1000;
step=(b2-b1)/NN;


x=[b1:step:b2]; % eta=x/b

%% set the power-law exponent and the origin of the x-coordinate
m=0.1;
q0=3.65;
x0=-200;
x1=x-x0;

%% power-law distributions of surface pressure, BEF and sin friction
p=q0-(x1).^(2*m);
dp0=((p-min(p))/(max(p)-min(p)))'; % Pa

bef0=-(x1').^((7*m-3)/2);
tor=x1.^((3*m-1)/2);



figure(1);
plot(x,p);
grid;
xlabel('x');
ylabel('p');

figure(2);
plot(x,dp0);
grid;
xlabel('x');
ylabel('Noma;ized dp');

figure(3);
plot(x,bef0);
grid;
xlabel('x');
ylabel('BEF');

figure(4);
plot(tor);
grid;
xlabel('x');
ylabel('Skin Friction');



%% images of power-law surface pressure and BEF 
k=1;
N=1000;
dp=[];
bef=[];
while k<=N
    dp=[dp dp0];
    bef=[bef bef0];
    k=k+1;
end

x_cut=1;
dp=dp(x_cut:end,:);
bed=bef(x_cut:end,:);



figure(10);
imagesc(dp);
colormap(gray);
colorbar;
axis image;
title('Noramlized dp');


figure(11);
imagesc(bef);
colormap(gray);
colorbar;
axis image;
title('BRF');


% save dp_Falkner_Skan_m0p1.dat dp -ascii;
% save bef_Falkner_Skan_m0p1.dat bef -ascii;















