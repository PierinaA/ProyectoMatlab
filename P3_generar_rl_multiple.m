%Programa obtener los descriptores para generar 
%la regresión lineal multiple

clear ;         %Elimina todas las variables
close all;      %Cierra todas las ventanas de gráficos
clc;            %Elimina el comand window
warning off;    %Desactiva las advertencias

%Lee la base de datos Uniendo las 2 grabaciones usaremos el metodo de
%"concatenar" (PIERINA)
[a1,Fs] = audioread("alumno4_vocal_a_1.wav");
[a2,~]  = audioread("alumno4_vocal_a_2.wav");
a = [a1;a2];

[e1,~] = audioread("alumno4_vocal_e_1.wav");
[e2,~] = audioread("alumno4_vocal_e_2.wav");
e = [e1;e2];

[i1,~] = audioread("alumno4_vocal_i_1.wav");
[i2,~] = audioread("alumno4_vocal_i_2.wav");
i = [i1;i2];

[o1,~] = audioread("alumno4_vocal_o_1.wav");
[o2,~] = audioread("alumno4_vocal_o_2.wav");
o = [o1;o2];

[u1,~] = audioread("alumno4_vocal_u_1.wav");
[u2,~] = audioread("alumno4_vocal_u_2.wav");
u = [u1;u2];
% % %Ejemplo de como concatenar 2 señales de audio
% [e1,~] = audioread("e1.wav");
% [e2,~] = audioread("e1.wav");
% e = [e1;e2];  
% clear e1 e2
% figure (); plot(e)

% if alummno = 1
%     a1 = audioread("alummo1_a1.wav");
%     a2 = audioread("alummo1_a1.wav");
%     e1 = audioread("alummo1_a1.wav");
%     e2 = audioread("alummo1_a1.wav");
%     umbral = 0.13
% elseif alummno = 2
%     a1 = audioread("alummo2_a1.wav");
%     a2 = audioread("alummo2_a1.wav");
%     e1 = audioread("alummo2_a1.wav");
%     e2 = audioread("alummo2_a1.wav");
%     umbral = 0.12
% end

figure();
subplot(3,2,1);plot(a);title("a");
subplot(3,2,2);plot(e);title("e");
subplot(3,2,3);plot(i);title("i");
subplot(3,2,4);plot(o);title("o");
subplot(3,2,5);plot(u);title("u");

%Puertos de Entrada y Salida del Computador
puertos = audiodevinfo(); %Para conocer los Puertos de Entrada y Salida del Computador
ID_O = 4;   %Dispositivo de reproducción del Prof. Dianderas

%Reproducción de audio
%reproductor = audioplayer(e,Fs,24,ID_O); (PIERINA)
% play(reproductor)

% Calculo bloques de inicio y fin de cada vocal
T_V = 30/1000; %Tiempo de Ventana
umbral = 0.40; %SOLAMENTE FUNCIONA PARA (PIERINA)

%Las posiciones del medio SÓLO se calculan 1 vez y es con la señal
%sin recuantizar

medio.a = obtener_pos(a,Fs,umbral,T_V);
medio.e = obtener_pos(e,Fs,umbral,T_V);
medio.i = obtener_pos(i,Fs,umbral,T_V);
medio.o = obtener_pos(o,Fs,umbral,T_V);
medio.u = obtener_pos(u,Fs,umbral,T_V);

rp = [3 4 5 6];

%Sin Recuantizar
%genera_rl_multiple(VOCAL,VOCAL,VOCAL,VOCAL,VOCAL,POS_MEDIO;FS;T_V
RL.N = genera_rl_multiple(a,e,i,o,u,medio,Fs,umbral,T_V);

%Factor de Escala Fijo
RL.FRP1 = genera_rl_multiple(rfijo(a,rp(1)),...
                             rfijo(e,rp(1)),...
                             rfijo(i,rp(1)),...
                             rfijo(o,rp(1)),...
                             rfijo(u,rp(1)),medio,Fs,umbral,T_V);

RL.FRP2 = genera_rl_multiple(rfijo(a,rp(2)),...
                             rfijo(e,rp(2)),...
                             rfijo(i,rp(2)),...
                             rfijo(o,rp(2)),...
                             rfijo(u,rp(2)),medio,Fs,umbral,T_V);

RL.FRP3 = genera_rl_multiple(rfijo(a,rp(3)),...
                             rfijo(e,rp(3)),...
                             rfijo(i,rp(3)),...
                             rfijo(o,rp(3)),...
                             rfijo(u,rp(3)),medio,Fs,umbral,T_V);

RL.FRP4 = genera_rl_multiple(rfijo(a,rp(4)),...
                             rfijo(e,rp(4)),...
                             rfijo(i,rp(4)),...
                             rfijo(o,rp(4)),...
                             rfijo(u,rp(4)),medio,Fs,umbral,T_V);

%Factor de Escala Adaptivo
RL.ARP1 = genera_rl_multiple(radaptivo(a,rp(1),T_V,Fs),...
                             radaptivo(e,rp(1),T_V,Fs),...
                             radaptivo(i,rp(1),T_V,Fs),...
                             radaptivo(o,rp(1),T_V,Fs),...
                             radaptivo(u,rp(1),T_V,Fs),medio,Fs,umbral,T_V);

RL.ARP2 = genera_rl_multiple(radaptivo(a,rp(2),T_V,Fs),...
                             radaptivo(e,rp(2),T_V,Fs),...
                             radaptivo(i,rp(2),T_V,Fs),...
                             radaptivo(o,rp(2),T_V,Fs),...
                             radaptivo(u,rp(2),T_V,Fs),medio,Fs,umbral,T_V);

RL.ARP3 = genera_rl_multiple(radaptivo(a,rp(3),T_V,Fs), ...
                             radaptivo(e,rp(3),T_V,Fs),...
                             radaptivo(i,rp(3),T_V,Fs),...
                             radaptivo(o,rp(3),T_V,Fs),...
                             radaptivo(u,rp(3),T_V,Fs),medio,Fs,umbral,T_V);

RL.ARP4 = genera_rl_multiple(radaptivo(a,rp(4),T_V,Fs), ...
                             radaptivo(e,rp(4),T_V,Fs),...
                             radaptivo(i,rp(4),T_V,Fs), ...
                             radaptivo(o,rp(4),T_V,Fs), ...
                             radaptivo(u,rp(4),T_V,Fs),medio,Fs,umbral,T_V);

RL.umbral = umbral;
RL.TV = T_V;
RL.rp = rp;
RL.Fs = Fs;

%Comando para guardar la red
save('Red_RL_N_F7.mat','RL')