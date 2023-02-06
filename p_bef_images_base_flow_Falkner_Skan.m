%% This program generates the base flow surface pressure and BEF fields (images)
%% using the Falkner-Skan flow solution.  

clear all
close all

%% flow parameters
roh=1; % kg/m^3
vis_kine=1.5*10^(-5); % m^2/s
V=1; % m/s
q_inf=0.5*roh*V^2; % Pa

%% normalized x-coordinate
x=[0.001:0.001:1]; % eta=x/b

%% outer flow pressure distribution
m=0.5; % power-law exponent if the outer flow U(x) = Cx^m
a=1;
f2=0.749*m.^0.5049+0.4696; % m=0-1
%f2=1.696*m+0.4741; % m=0-0.2
p=q_inf-0.5*roh*a^2*x.^(2*m);


figure(1);
plot(x,p);
grid;
xlabel('x');
ylabel('p');


%% normalized pressure difference and BEF
dp0=((p-min(p))/(max(p)-min(p)))'; % Pa

vis_dyn=vis_kine*roh;
beta=2*m/(m+1);
bef0=-vis_dyn*beta*(0.5*(m+1)*a/vis_kine)^(3/2)*a^2*f2*(x').^((7*m-3)/2);

figure(2);
plot(x,dp0);
grid;
xlabel('x');
ylabel('dp');

figure(3);
plot(x,bef0);
grid;
xlabel('x');
ylabel('BEF');


%% pressure difference and BEF fields (images)
k=1;
N=1000;
dp=[];
bef=[];
while k<=N
    dp=[dp dp0];
    bef=[bef bef0];
    k=k+1;
end


figure(4);
imagesc(dp);
colormap(gray);
colorbar;
axis image;
xlabel('x');
ylabel('y');
title('Pressure Difference');


figure(5);
imagesc(bef);
colormap(gray);
colorbar;
axis image;
xlabel('x');
ylabel('y');
title('BEF');


% save dp_Falkner_Skan_m0p5.dat dp -ascii;
% save bef_Falkner_Skan_m0p5.dat bef -ascii;















