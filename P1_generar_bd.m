%Programa para grabar audio y generar la Base de Datos
% Consejo siempre grabar como máximo 10 rep por archivo

clear ;         %Elimina todas las variables
close all;      %Cierra todas las ventanas de gráficos
clc;            %Elimina el comand window
warning off;    %Desactiva las advertencias

%Párametros de Captura
Fs = 8000;  %Frecuencia de muestreo en Hz o muestras/segundo
T = 1/Fs;  %Periodo de muestreo en segundos
Tc = 25;     %Tiempo de captura en segundos (PIERINA)
r = 24;      %Número de bits para codificar la señal (8, 14 o 24)

%Definición de puertos de Entrada y Salida del Computador
puertos = audiodevinfo(); %Para conocer los Puertos de Entrada y Salida del Computador

%Dispositivo de grabación del Prof. Dianderas, colocar el suyo
%Nombre Microfono Laptop: 'Micrófono (Realtek High Definition Audio) (Windows DirectSound)'

%Dispositivo de reproducción del Prof. Dianderas, colocar el suyo
%Nombre Parlantes Laptop: 'Altavoces (Realtek High Definition Audio) (Windows DirectSound)'

ID_I = puertos.input(2).ID;   
ID_O = puertos.output(2).ID;
n_c = 1;    %número de canales: 1 mono - 2 estereo

%Despliegue grabadora
grabadora = audiorecorder(Fs,r,n_c,ID_I);
input('Presiona Enter para empezar a grabar...');
record(grabadora, Tc);
pause(Tc+1);
disp('¡Audio Grabado!')
x = getaudiodata(grabadora,'double');
% Acondicionamiento al 80% (PIERINA)
max_amp = max(abs(x));
if max_amp < 0.8
    x = x * (0.8 / max_amp);
    disp('Se aplicó ganancia para llegar al 80%');
end

t = 0:T:Tc-T;

figure();plot(t,x);title("Señal Capturada");xlabel("Tiempo");

%Reproducción de audio
reproductor = audioplayer(x,Fs,r,ID_O);
play(reproductor)
% 
%Calculo del espectrograma
tiempo_ventana = 30*1e-3;    %Tamaño de la venta en tiempo (ms)
tiempo_traslape = 0;   %Tiempo de traslape entre bloque y bloque en ms

tam_ventana = Fs*tiempo_ventana; %Tamaño en número de muestras del bloque
tam_traslape = Fs*tiempo_traslape; %Tamaño en número de muestra del traslape

nfft = 2^nextpow2(tam_ventana);

figure();spectrogram(x,tam_ventana,tam_traslape,nfft,Fs,'yaxis');
title('Espectrograma de la Señal');

%Transformada de fourier 1
[X,FREC] = fourier(x,Fs);

figure()
subplot(2,1,1);plot(FREC, abs(X));title('Espectro de Magnitud');
xlabel('Frecuencia (Hz)'); ylabel('Amplitud');
grid on;    %cuadricula
subplot(2,1,2);plot(FREC,20*log10(abs(X)));title('Espectro de Magnitud - dB');
xlabel('Frecuencia (Hz)'); ylabel('Amplitud');
grid on;    %cuadricula

%Comando para grabar audio (PIERINA)
 audiowrite("vocales2_alumno4.wav",x,Fs);