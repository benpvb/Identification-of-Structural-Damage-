clc; clear; close all;

addpath('E:\My_Study_2021');

u1 = table2array(readtable('Case1.xlsx'));

u2 = table2array(readtable('Case2.xlsx'));

u8 = table2array(readtable('Case8.xlsx'));

sr = 200;

dt = 1/sr;

npoint = length(u1(:,1));

time = 0:dt:(dt*(npoint-1));

y1 = lowpassfileter(u1,time,sr);
y2 = lowpassfileter(u2,time,sr);
y8 = lowpassfileter(u8,time,sr);

y1T = y1(:,1:2:end) - y1(:,2:2:end);
y2T = y2(:,1:2:end) - y2(:,2:2:end);
y8T = y8(:,1:2:end) - y8(:,2:2:end);
%% Perform Sammon Map.
signal_names = {'1','2','3',...
                '4','5','6',...
                '1','2','3',...
                '4','5','6'};
%% Perform PCA Map
% Step 1: construct the X matrix containing ground motion intensity.
 X = [y1T y8T]';
  [UU, DD] = svd(X);
   DD = diag(DD);
   figure;
   plot(DD,'*');
   ylabel('Eigen Value');
   xlabel('Component');
 

 [ySammon, yPCA] = sammon(X);
  yPCA = yPCA./max(sqrt(yPCA(:,1).^2 + yPCA(:,2).^2));
  ySammon= ySammon./max(sqrt(ySammon(:,1).^2 + ySammon(:,2).^2));

figure('position',[50 50 680 680]);  
for i = 1:6
    v1(i) = plot(yPCA(i,1), yPCA(i,2),'ko','markerface','r','markersize',12); hold on;
    v2(i) = plot(yPCA(i+6,1), yPCA(i+6,2),'ko','markerface','b','markersize',12); hold on;
    text(1.2*yPCA(i,1), 1.1*yPCA(i,2), signal_names{i},'Color','r');
    text(1.2*yPCA(i+6,1), 1.1*yPCA(i+6,2), signal_names{i},'Color','b');
end
    legend([v1(1);v2(1)],'Case-1','Case-8','location','best');
    title('PCA-Map');
    xlabel('X-coor','fontsize',14);
    ylabel('Y-coor','fontsize',14);
    axis([-1 1 -1 1]);
    set(gca,'Xtick',-1:0.2:1);
    set(gca,'Ytick',-1:0.2:1);
    axis equal;
    set(gca,'fontsize',12);

%%
% signal_names = {'A1a','A1b','A2a','A2b','A3a','A3b',...
%                 'A4a','A4b','A5a','A5b','A6a','A6b'};
% D = pdist(X)./max(pdist(X)); 
% ySammon = mdscale(D,2, 'criterion','sammon');

% Q = [cos(deg2rad(dip)) -sin(deg2rad(dip)); sin(deg2rad(dip)) cos(deg2rad(dip))];
% ymom = ymom*Q; ymom = bsxfun(@minus,ymom,ymom(1,:));

figure('position',[50 50 680 680]);  
for i = 1:6
    v1(i) = plot(ySammon(i,1), ySammon(i,2),'ko','markerface','r','markersize',12); hold on;
    v2(i) = plot(ySammon(i+6,1), ySammon(i+6,2),'ko','markerface','b','markersize',12); hold on;
    text(1.2*ySammon(i,1), 1.1*ySammon(i,2), signal_names{i},'Color','r');
    text(1.2*ySammon(i+6,1), 1.1*ySammon(i+6,2), signal_names{i},'Color','b');
end
    legend([v1(1);v2(1)],'Case-1','Case-8','location','best');
title('Sammon Map');
xlabel('X-coor','fontsize',14);
ylabel('Y-coor','fontsize',14);
axis([-1 1 -1 1]);
set(gca,'Xtick',-1:0.2:1);
set(gca,'Ytick',-1:0.2:1);
set(gca,'fontsize',12);

fig_name = 'figures\Map_Case12.png';
print(gcf, fig_name,'-dpng','-r300');   

 

%%
ddfdfd
ddffjdjfdfj
