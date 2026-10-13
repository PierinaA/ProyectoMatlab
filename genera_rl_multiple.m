function RL = genera_rl_multiple(a,e,i,o,u,medio,Fs,umbral,T_V)

%Obtención de descriptores
BD.a = descriptores(a,Fs,medio.a,T_V);
BD.e = descriptores(e,Fs,medio.e,T_V);
BD.i = descriptores(i,Fs,medio.i,T_V);
BD.o = descriptores(o,Fs,medio.o,T_V);
BD.u = descriptores(u,Fs,medio.u,T_V);

%LA BD ES PARA OBTENER EL A Y B DE LA RL

%Regresión Lineal
RL.a = entrenar(BD.a,BD.e,BD.i,BD.o,BD.u);
RL.e = entrenar(BD.e,BD.a,BD.i,BD.o,BD.u);
RL.i = entrenar(BD.i,BD.a,BD.e,BD.o,BD.u);
RL.o = entrenar(BD.o,BD.a,BD.e,BD.i,BD.u);
RL.u = entrenar(BD.u,BD.a,BD.e,BD.i,BD.o);

% RL.a.rp4 = entrenar(BD.a.rp4,BD.e.rp4,BD.i.rp4,BD.o.rp4,BD.u.rp4);
end