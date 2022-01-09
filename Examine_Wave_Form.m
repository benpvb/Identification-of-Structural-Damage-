clc; clear; close all;

addpath('E:\My_Study_2021');

u1 = table2array(readtable('Case1.xlsx'));

u2 = table2array(readtable('Case2.xlsx'));

u8 = table2array(readtable('Case8.xlsx'));

sr = 200;

dt = 1/sr;

npoint = length(u1(:,1));

time = 0:dt:(dt*(npoint-1));

[y1, ts] = lowpassfileter(u1,time,sr);

y2 = lowpassfileter(u2,time,sr);

y8 = lowpassfileter(u8,time,sr);

% signal_names = {'A1a','A1b','A2a','A2b','A3a','A3b',...
%                 'A4a','A4b','A5a','A5b','A6a','A6b'};


% for i = 1
%     fig = figure('Position',[20 20 1280 320]);
%     figure;
%     plot(time,u1(:,i)); hold on;
%     plot(ts,y1(:,i),'c');
%     legend('200hz Signal');
%     xlabel('time, s');
%     ylabel('Amp');
%     title('case-1');
%     ylim([-0.2 0.2]);
% 
%     subplot(1,3,2)
%     plot(u2(:,i)); hold on;
%     plot(ts,y2(:,i),'c');
%     xlabel('time, s');
%     ylabel('Amp');
%     title('case-2');
%     ylim([-0.2 0.2]);
% 
%     subplot(1,3,3)
%     plot(u8(:,i)); hold on;
%     plot(ts,y8(:,i),'c');
%     xlabel('time, s');
%     ylabel('Amp');
%     title('case-8');
%     ylim([-0.2 0.2]);
% 
% %     fig_name = strcat('timeseries_',signal_names{i},'.png');
% %     saveas(fig, ['E:\My_Study_2021\Matlab_Program\figures\',fig_name]);  
% end

 sw = 'fas';
 dt2 = 1/50;
 EAS1arr = [];
 EAS2arr = [];
 EAS8arr = [];

 for i = 1:2:11
     S1a = OpenSeismoMatlab(dt2,y1(:,i),sw);
     S1b = OpenSeismoMatlab(dt2,y1(:,i+1),sw);
     EAS1 = sqrt(0.5*S1a.FAS.^2 + 0.5*S1b.FAS.^2);

     S2a = OpenSeismoMatlab(dt2,y2(:,i),sw);
     S2b = OpenSeismoMatlab(dt2,y2(:,i+1),sw);
     EAS2 = sqrt(0.5*S2a.FAS.^2 + 0.5*S2b.FAS.^2);

     S8a = OpenSeismoMatlab(dt2,y8(:,i),sw);
     S8b = OpenSeismoMatlab(dt2,y8(:,i+1),sw);
     EAS8 = sqrt(0.5*S8a.FAS.^2 + 0.5*S8b.FAS.^2);

     EAS1arr = [EAS1arr EAS1];
     EAS2arr = [EAS2arr EAS2];
     EAS8arr = [EAS8arr EAS8];

%      figure;
%      plot(S1a.freq,S1a.FAS); hold on;
%      plot(S1b.freq,S1b.FAS);
%      legend('200hz Signal','50hz Signal')
%      xlabel('Freq, hz');
%      ylabel('FAS');
 end

%% 
signal_names = {'1','2','3',...
                '4','5','6',...
                '1','2','3',...
                '4','5','6'};

X = [EAS1arr EAS8arr]';
D = pdist(X)./max(pdist(X)); 
ySammon = mdscale(D,2, 'criterion','sammon');

% Q = [cos(deg2rad(dip)) -sin(deg2rad(dip)); sin(deg2rad(dip)) cos(deg2rad(dip))];
% ymom = ymom*Q; ymom = bsxfun(@minus,ymom,ymom(1,:));
cm = lines(6);
figure('position',[50 50 680 680]);  
for i = 1:6
    v1(i) = plot(ySammon(i,1), ySammon(i,2),'ko','markerface','r','markersize',12); hold on;
    v2(i) = plot(ySammon(i+6,1), ySammon(i+6,2),'ko','markerface','b','markersize',12); hold on;
    text(1.2*ySammon(i,1), 1.2*ySammon(i,2), signal_names{i},'Color','r');
    text(1.2*ySammon(i+6,1), 1.2*ySammon(i+6,2), signal_names{i},'Color','b');
end
    legend([v1(1);v2(1)],'Case-1','Case-8','location','best');
% title('Case-8');
xlabel('X-coor','fontsize',14);
ylabel('Y-coor','fontsize',14);
axis([-1 1 -1 1]);
set(gca,'fontsize',12);

fig_name = 'figures\FAS_Map_Case18.png';
print(gcf, fig_name,'-dpng','-r300');   