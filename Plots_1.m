
figure(1);
imagesc(I2);
colormap('pink');
axis image;
colorbar;
title('Normalized Pressure');
xlabel('x (pixels)');
ylabel('y (pixels)');

figure(2);
imagesc(bef/max(max(abs(bef))));
colormap('pink');
axis image;
colorbar;
title('Normalized BEF');
xlabel('x (pixels)');
ylabel('y (pixels)');

[m,n]=size(tor_x);

x1=1;
x2=n;
y1=1;
y2=m;

figure(40);
%imagesc(tor_mag(y1:y2,x1:x2));
colormap('pink');
%hold on;
colorbar;

% plot initial velocity vector field and streamlines
figure(40);
gx=50; offset=1;
[Vx Vy] = vis_flow (tor_x(y1:y2,x1:x2), tor_y(y1:y2,x1:x2), gx, offset, 2, 'm');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Skin Friction Vectors and Magnitude Field');
hold off;



figure(42);
imagesc(I2);
colormap('pink');
axis image;
colorbar;
xlabel('x (pixels)');
ylabel('y (pixels)');
hold on;

% plot streamlines
figure(42);
[m,n]=size(tor_x);
[x,y]=meshgrid(1:n,1:m);
dn=10;
dm=10;
[sx,sy]=meshgrid(1:dn:n,1:dm:m);
%h=streamline(x, y, ux, uy, sx, sy);
h=streamslice(x(y1:y2,x1:x2), y(y1:y2,x1:x2), tor_x(y1:y2,x1:x2), tor_y(y1:y2,x1:x2), 10);
set(h, 'Color', 'blue');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Skin Friction Lines and Normalized Pressure');
hold off;


% save tor_x_fin_shock.dat tor_x_corr -ascii;
% save tor_y_fin_shock.dat tor_y_corr -ascii;








