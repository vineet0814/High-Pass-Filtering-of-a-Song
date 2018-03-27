Fs=44100;                          % sampling frequency 
Wp = 500/22050; Ws = 1000/22050;   % Normalizing the frequency
[n,Wn] = buttord(Wp,Ws,-0.9,45);    % Gives minimum order of filter
[b,a] = butter(n,Wn,'low');
figure(1);freqs(b,a);              % Plot CT frequency response
[BZ,AZ] = impinvar(b,a,Fs);
figure(2);freqz(BZ,AZ);
[BZ1,AZ1] = bilinear(b,a,Fs);
figure(3);freqz(BZ1,AZ1);

S =load('Song.mat');
data=S.data;
data_out=filter(b,a,data);
sound(data,S.fs);
sound(data_out,S.fs)

Nfft=256; window=140; overlap=window-1;
[SP,freq,time]=spectrogram(data,window,overlap,Nfft,Fs);
[SP_filtered,freq,time]=spectrogram(data_out,window,overlap,Nfft,Fs);
figure(2); subplot(211); samp_freq=30; freq_short=freq(1:samp_freq);
imagesc(time,freq_short,abs(SP(1:samp_freq,:))); axis xy
xlabel('Time, s'); ylabel('Frequency, Hz'); title('Song recording'); figure(2); subplot(212)
imagesc(time,freq_short,abs(SP_filtered(1:samp_freq,:))); axis xy
xlabel('Time, s'); ylabel('Frequency, Hz'); title('Filtered song recording');

