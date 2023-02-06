%% This program generates the near-wall flow strcutures based on the surface pressure and skin
%% friction fields using the Taylor-series expansion solution of the NS equations. 

clear all;
close all;


%% load the surface pressure and skin friction data files
p=load('dp_Falkner_Skan_m0p5_fin_shock.dat'); 
tor_x=load('tor_x_fin_shock.dat');
tor_y=load('tor_y_fin_shock.dat');
%% load the mask file
BW=load('BW_fin.dat'); 

%% filter the skin friction field
mask_size=1;
std=0.61*mask_size;
h=fspecial('gaussian',mask_size,std);
p=imfilter(p,h);
tor_x=imfilter(tor_x,h);
tor_y=imfilter(tor_y,h);

%% set flow parameters
roh=1; % kg/m^3
vis_kine=1.5*10^(-5); % m^2/s
V=1; % m/s
L=1;
ReL=V*L/vis_kine;
q_inf=0.5*roh*V^2; % Pa

%% calculate gradients and divergence
[dpx,dpy] = gradient(p);
div_tor = divergence(tor_x,tor_y);

[dtorxx,dtorxy] = gradient(tor_x);
[dtoryx,dtoryy] = gradient(tor_y);

lap_tor_x = del2(tor_x);
lap_tor_y = del2(tor_y);
lap_p = del2(p);

[d_div_tor_x,d_div_tor_y] = gradient(div_tor);

%% calculate the 3 components of velocity and enstrophy near a wall
u_add=[];
v_add=[];
w_add=[];

x1=300;
x2=700;
y1=300;
y2=700

d=10;

z1=[1:10:200];

for i=2:length(z1)
    z=z1(i);
    u=ReL*(tor_x.*z+(1/2)*dpx.*z.^2+(1/6)*z.^3*(-lap_tor_x-d_div_tor_x));
    v=ReL*(tor_y.*z+(1/2)*dpy.*z.^2+(1/6)*z.^3*(-lap_tor_y-d_div_tor_y));
    w=ReL*(-(1/2)*z.^2*div_tor-(1/6)*z.^3*lap_p);
    
    u_add(:,:,i)=u(y1:d:y2,x1:d:x2);
    v_add(:,:,i)=v(y1:d:y2,x1:d:x2);    
    w_add(:,:,i)=w(y1:d:y2,x1:d:x2);
    
    
    omega_x=ReL*(tor_y+dpy.*z+(1/1)*z.^2.*lap_tor_y);
    omega_y=-ReL*(tor_x+dpx.*z+(1/1)*z.^2.*lap_tor_x);   
    omega_z=ReL*z.*(dtoryx+dtorxy);
    
    enstrophy=omega_x.^2+omega_y.^2+omega_z.^2;
   
    value_background=0;
    enstrophy=(ones(size(BW))-BW).*enstrophy+value_background*BW; % outside
    
    omega_x_add(:,:,i)=omega_x(y1:d:y2,x1:d:x2);
    omega_y_add(:,:,i)=omega_y(y1:d:y2,x1:d:x2);
    omega_z_add(:,:,i)=omega_z(y1:d:y2,x1:d:x2);
    
    enstrophy_add(:,:,i)=enstrophy(y1:d:y2,x1:d:x2);
  
    i
end

u3d=u_add;
v3d=v_add;
w3d=w_add;

enstrophy3d=enstrophy_add;

omega_x3d=omega_x_add;
omega_y3d=omega_y_add;

%% generate plots
x=[1:length(u3d(:,1,1))];
y=[1:length(u3d(1,:,1))];    
z=[1:length(u3d(1,1,:))];

xmin = min(x(:));
xmax = max(x(:));
ymin = min(y(:));
ymax = max(y(:));
zmin = min(z(:));
zmax = max(z(:));


figure(1);
[sx sy sz] = meshgrid(xmin:3:xmax,ymin:3:ymax,zmin:3:zmax);
h = streamline(x,y,z,u3d,v3d,w3d,sx,sy,sz);
set(h,'LineWidth',0.5,'Color','red');
view([-30 80]);
axis on;
grid off;
box on;
xlabel('x');
ylabel('y');
zlabel('z');
axis([0 40 0 50 0 20]);
title('Near-Wall Streamlines');


figure(2);
colormap(hot);
contourslice(enstrophy3d,[60],[60],[5],200);
view([-30 80]);
beta = .7;
brighten(beta)
axis tight
grid;
xlabel('x');
ylabel('y');
zlabel('z');
axis([0 40 0 50 0 20]);
title('Near-Wall Enstrophy Contous');
















