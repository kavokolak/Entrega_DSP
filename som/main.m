%% clear all

clear all

%% leitura
[Y,Fs]=audioread('som.wav');

%% cortar 10s
N=Fs*10;
audio=Y(1:N,1);

%% Plot em amostras
figure;
subplot(2,1,2);
plot(audio)
title('Audio em amostras');
%% Plot em tempo
Ts = 1/Fs;              % periodo
tf = size(audio,1)*Ts;  % tempo total do audio
t  = (0:Ts:(tf-Ts))';   % vetor tempo em (s)
subplot(2,1,1);
plot (t,audio);
title('Audio no tempo');
%% FFT
NFFT = 2^nextpow2(N); % Next power of 2 from length of y
F = fft(audio,NFFT)/N;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure;
subplot(2,1,1);
plot(f,2*abs(F(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)10s')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


%% cortar 50s
N=Fs*50;
audio=Y(1:N,1);

%% FFT
NFFT = 2^nextpow2(N); % Next power of 2 from length of y
F = fft(audio,NFFT)/N;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
subplot(2,1,2);
plot(f,2*abs(F(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)50s')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%% Waterfall
X = N;
Y = f;
Z = 2*abs(F(1:NFFT/2+1));
figure
waterfall(X,Y,Z);
