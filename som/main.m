%% clear all

clear all

%% leitura
[Y,Fs]=audioread('som.wav');

%% Som no Tempo

%% cortar 10s
N=Fs*10;
audio=Y(1:N,1);

%%plot
figure;
plot(audio)

%%FFT
NFFT = 2^nextpow2(N); % Next power of 2 from length of y
F = fft(audio,NFFT)/N;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure;
subplot(2,1,1);
plot(f,2*abs(F(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


%% cortar 50s
N=Fs*50;
audio=Y(1:N,1);

%%plot
subplot(2,1,2);
plot(audio)

%%FFT
NFFT = 2^nextpow2(N); % Next power of 2 from length of y
F = fft(audio,NFFT)/N;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
subplot(2,1,2);
stem(f,2*abs(F(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

