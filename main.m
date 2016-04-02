%% Rafael Corsi 
% Núcleo de Sistemas Eletrônicos Embarcados - NSE^2
% Script de geração de ECG para tratamento de sinais em HIL
% com o Elvis USB
clear all;
close all;

%% Taxa de amostragem
Ts = 0.1E-3;
Fs = 1/Ts;

%% Carrega dados previamente gerados com script em ECG_api
load ecg_dados;

% Cria vetor de dados utilizado pelo simulink
dado.time = [];

% Interpola o dado linearmente para alteara a taxa de amostragem
x_interpolacao = Fs/(size(ecg_p.x,2)/max(ecg_p.x));
dado.signals.values = interp(ecg_p.y', x_interpolacao) ; 

%% Plota sinal
figure
    plot([dado.signals.values; dado.signals.values])
    title('ECG com taxa de amostragem de Ts = 1E-3')

    

%% FFT do ECG sem ruído
% implementar 
NFFT = 2^nextpow2(Fs); % Next power of 2 from length of y
F = fft(dado.signals.values,NFFT)/Fs;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure;
plot(f,2*abs(F(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%% Executa simulação
%%ecg_modelo;

%% Plota gráfico do ECG
% implementar
load ecg_noise;
figure
plot(ecg_noise(:,2),ecg_noise(:,1))
title('ECG com ru�do')

%% FFT do ECG com ruído
% implementar 

NFFT = 2^nextpow2(Fs); % Next power of 2 from length of y
F = fft(ecg_noise,NFFT)/Fs;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure;
plot(f,2*abs(F(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')

%% Plota gráfico do ECG filtrado
% implementar

figure
plot(ecg_fir)
title('ECG filtrado')

%% FFT do ECG com ruído filtrado
% implementar 

NFFT = 2^nextpow2(Fs); % Next power of 2 from length of y
F = fft(ecg_fir,NFFT)/Fs;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
figure;
plot(f,2*abs(F(1:NFFT/2+1))) 
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
   
%% ------------------------------- parte 2
% Executa HIL
%-------------------------------
% Vamos usar uma placa de aquisição para gerar sinais
% de um vetor

% aqui carregamos a lista de placas e escolhermos dentre elas uma
devices = daq.getDevices                      
devices(1)

s = daq.createSession('ni')

% configuramos a saída análogica 0
addAnalogOutputChannel(s,'Dev4',0,'Voltage')

% Configura a taxa de amostragem
s.Rate = Fs;

%% Validando saida - parte 1
% coloca 1 V no D/A para verifcar se está ok
outputSingleScan(s, 2)

%% Validando saida com sin - parte 2
outputSignal = sin(linspace(0,pi*24,s.Rate)');
plot(outputSignal);
xlabel('Time');
ylabel('Voltage');

% aqui usamos outra função, colocamos um vetor no buffer
queueOutputData(s,outputSignal);

% inicializa o processo
s.startForeground;

%% HIL do ECG sem ruido
ecg = [dado.signals.values; dado.signals.values; dado.signals.values];
queueOutputData(s,ecg);
s.startForeground;

%% HIL do ECG com ru�do
queueOutputData(s,ecg_noise(:,1));
s.startForeground;
