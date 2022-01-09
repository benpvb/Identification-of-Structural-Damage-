function [y_smooth, ts] = lowpassfileter(y,time,sr)

    filtering_frequency = 50; %∫I§Ó¿W≤v 
    nstep = sr/50;
    y_smooth = [];
    for ii = 1:size(y,2)
        [Para_B,Para_A]=butter(10,filtering_frequency/(0.5*sr),'low');
        
        Acc = y(:,ii);
        Y_filtered = filtfilt(Para_B,Para_A,Acc); %Zero phase shift filter
        clear Para_A Para_B I
        FAcc = Y_filtered(1:nstep:end);
        y_smooth = [y_smooth FAcc];
    end
        ts = time(1:nstep:end);
end