clc; 

clear; 

close all;

data = readtable("6.xlsx");

figure;
plot(data.Time, data.Resistance);
xlabel('Time');
ylabel('Amplitude');

%% Fourier amplitude spectrum and mean period
dt = mean(diff(data.Time));
xgtt = data.Resistance;

%% Fourier amplitude spectrum and mean period
% Nyquist frequency (highest frequency)
Ny = (1/dt)/2; 
% number of points in xgtt
L  = length(xgtt); 
% Next power of 2 from length of xgtt
NFFT = 2^nextpow2(L);
% frequency spacing
df = 1/(NFFT*dt);
% Fourier amplitudes 
U = abs(fft(xgtt,NFFT))*dt; 
% Single sided Fourier amplitude spectrum
U = U(2:Ny/df+1);
% frequency range
f = linspace(df,Ny,Ny/df)'; 

figure(3);
plot(f, U);
axis([ 0 5 0 100000]);
xlabel('Freq, hz');
ylabel('Amplitude');