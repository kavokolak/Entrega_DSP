%% Limpa todas as variáveis

clear all


%% Leitura do audio para virar matriz
[Y,Fs]=audioread('AutumnLeaves_ruido.wav');

Yr = Y(:,1);

%% Corta 10s da música
N=Fs*10;
audio10=Yr(1:N,1);


%% Plota o trecho do audio cortado
figure;
plot(audio10)

%% FFT do audio cortado
NFFT = 2^nextpow2(N); % Next power of 2 from length of y
F = fft(audio10,NFFT)/N;
f = Fs/2*linspace(0,1,NFFT/2+1);

figure;
stem(f,2*abs(F(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%% Spectograma do audio cortado
figure
[S,F,T,P] = spectrogram(audio10,512,256,2048,Fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);
xlabel('Time (Seconds)'); ylabel('Hz');

%% Projetando filtro para remover ruído

load filtro1;
load filtro2;

audio_filtrado1= sosfilt(Hd.sosMatrix,audio10);
audio_filtrado2= sosfilt(Hd2.sosMatrix,audio_filtrado1);

NFFT = 2^nextpow2(N); % Next power of 2 from length of y
F = fft(audio_filtrado2,NFFT)/N;
f = Fs/2*linspace(0,1,NFFT/2+1);

% FFT do audio filtrado
figure;
stem(f,2*abs(F(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

% Spectograma do audio filtrado

figure
[S,F,T,P] = spectrogram(audio_filtrado2,512,256,2048,Fs);
surf(T,F,10*log10(P),'edgecolor','none'); axis tight; 
view(0,90);
xlabel('Time (Seconds)'); ylabel('Hz');

audio = audioplayer(audio_filtrado2, Fs);
play(audio)


