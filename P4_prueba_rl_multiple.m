%Programa para probar la regresión lineal multiple

clear ;         %Elimina todas las variables
close all;      %Cierra todas las ventanas de gráficos
clc;            %Elimina el comand window
warning off;    %Desactiva las advertencias

%Ahora se predice el nuevo archivo
[x,Fs] = audioread("vocales2_alumno4.wav");
%  load('Red_RL_N.mat');

load('Red_RL_N_F7.mat');

x_frp1 = rfijo(x,RL.rp(1));
x_frp2 = rfijo(x,RL.rp(2));
x_frp3 = rfijo(x,RL.rp(3));
x_frp4 = rfijo(x,RL.rp(4));
x_arp1 = radaptivo(x,RL.rp(1),RL.TV,RL.Fs);
x_arp2 = radaptivo(x,RL.rp(2),RL.TV,RL.Fs);
x_arp3 = radaptivo(x,RL.rp(3),RL.TV,RL.Fs);
x_arp4 = radaptivo(x,RL.rp(4),RL.TV,RL.Fs);

%Las posiciones del medio SÓLO se calculan 1 vez y es con la señal
%sin recuantizar
pos_medio = obtener_pos(x,Fs,RL.umbral,RL.TV);

x_test.n = descriptores(x,Fs,pos_medio,RL.TV); %x_test es lo que se se va a predecir con las RL

x_test.frp1 = descriptores(x_frp1,Fs,pos_medio,RL.TV); %x_test es lo que se se va a predecir con las RL
x_test.frp2 = descriptores(x_frp2,Fs,pos_medio,RL.TV); %x_test es lo que se se va a predecir con las RL
x_test.frp3 = descriptores(x_frp3,Fs,pos_medio,RL.TV); %x_test es lo que se se va a predecir con las RL
x_test.frp4 = descriptores(x_frp4,Fs,pos_medio,RL.TV); %x_test es lo que se se va a predecir con las RL

x_test.arp1 = descriptores(x_arp1,Fs,pos_medio,RL.TV); %x_test es lo que se se va a predecir con las RL
x_test.arp2 = descriptores(x_arp2,Fs,pos_medio,RL.TV); %x_test es lo que se se va a predecir con las RL
x_test.arp3 = descriptores(x_arp3,Fs,pos_medio,RL.TV); %x_test es lo que se se va a predecir con las RL
x_test.arp4 = descriptores(x_arp4,Fs,pos_medio,RL.TV); %x_test es lo que se se va a predecir con las RL

letras_n = identificar(x_test.n,RL.N,pos_medio);

letras_frp1 = identificar(x_test.frp1,RL.FRP1,pos_medio);
letras_frp2 = identificar(x_test.frp2,RL.FRP2,pos_medio);
letras_frp3 = identificar(x_test.frp3,RL.FRP3,pos_medio);
letras_frp4 = identificar(x_test.frp4,RL.FRP4,pos_medio);

letras_arp1 = identificar(x_test.arp1,RL.ARP1,pos_medio);
letras_arp2 = identificar(x_test.arp2,RL.ARP2,pos_medio);
letras_arp3 = identificar(x_test.arp3,RL.ARP3,pos_medio);
letras_arp4 = identificar(x_test.arp4,RL.ARP4,pos_medio);

salida = [letras_n;
          letras_frp1;letras_frp2;letras_frp3;letras_frp4;
          letras_arp1;letras_arp2;letras_arp3;letras_arp4];

tabla = [letras_n'...
         letras_frp1' letras_frp2' letras_frp3' letras_frp4'...
         letras_arp1' letras_arp2' letras_arp3' letras_arp4'];

etiquetas = ["Normal",...
             "FRP1:"+ num2str(RL.rp(1)), "FRP2:"+num2str(RL.rp(2)),...
             "FRP3:"+ num2str(RL.rp(3)), "FRP4:"+num2str(RL.rp(4)),...
             "ARP1:"+ num2str(RL.rp(1)), "ARP2:"+num2str(RL.rp(2)),...
             "ARP3:"+ num2str(RL.rp(3)), "ARP4:"+num2str(RL.rp(4))];

for i = 1:size(tabla,1)
    fprintf('Segmento %d -> ', i);
    for j = 1:size(tabla,2)
        fprintf('%s=%c ', etiquetas(j), tabla(i,j));
    end
    fprintf('\n');
end