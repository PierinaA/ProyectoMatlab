%Programa para calcular el umbral de que es sonido
% Consejo siempre grabar como máximo 10 rep por archivo

clear;    %Elimina todas las variables
close all;          %Cierra todas las ventanas de gráficos
clc;                %Elimina el comand window

%Lee la base de datos (PIERINA)
[audio,Fs] = audioread("alumno4_vocal_u_2.wav"); 

figure();
plot(audio);title("a");

%Puertos de Entrada y Salida del Computador
puertos = audiodevinfo();
ID_O = 4;   %Dispositivo de reproducción del Prof. Dianderas
n_c = 1;    %número de canales: 1 mono - 2 estereo
%Reproducción de audio
%reproductor = audioplayer(audio,Fs,24,ID_O); (PIERINA)
% play(reproductor)

% Calculo bloques de inicio y fin de cada vocal
T_V = 30/1000; %Tiempo de Ventana
P = T_V*Fs; %Tamaño del bloque en número de muestras
bloques = buffer(audio,P); %Segmento en P muestras a la variable vocal
[~,num_bloques] = size(bloques);
energia_bloques = zeros(1,num_bloques);
for i = 1:num_bloques
    bloque_act = bloques(:,i);   %Extraigo el bloque de tamaño de ventana
    energia_bloques(i) = sum(bloque_act.^2);
end


figure()
stem(energia_bloques);xlabel("número de bloque");
ylabel("Energia");title("Energía por bloque");

%ACA CAMBIAR 
umbral = 0.40;% (PIERINA)
sup_energia = energia_bloques>=umbral;
figure()
stem(sup_energia);xlabel("número de bloque");
title("Bloques que superan umbral");

sup_energia = rellenar(sup_energia);

bloq_inicio=[]; 
bloq_fin=[];

for i = 4:num_bloques-3
    blo_ant_3 = sup_energia(i-3);
    blo_ant_2 = sup_energia(i-2);
    blo_ant_1 = sup_energia(i-1);
    blo_act = sup_energia(i);
    blo_sup1 = sup_energia(i+1);
    blo_sup2 = sup_energia(i+2);
    blo_sup3 = sup_energia(i+3);

    if ((blo_ant_3==0)&&(blo_ant_2==0)&&(blo_ant_1==0)&&...
            (blo_act==1)&&(blo_sup1==1)&&(blo_sup2==1)&&(blo_sup3==1))
        bloq_inicio=[bloq_inicio i];
    end

    if ((blo_ant_3==1)&&(blo_ant_2==1)&&(blo_ant_1==1)&&...
            (blo_act==1)&&(blo_sup1==0)&&(blo_sup2==0)&&(blo_sup3==0))
        bloq_fin=[bloq_fin i];
    end
end

if ((sup_energia(end-3)==1)&&(sup_energia(end-2)==1)&&(sup_energia(end-1)==1)...
        &&(sup_energia(end)==1))
    bloq_fin = [bloq_fin i];
end
b_medio = round((bloq_fin+bloq_inicio)./2);