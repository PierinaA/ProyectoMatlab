function rellenado = rellenar(son)

num_bloques = length(son);
rellenado = son;
for i = 4:num_bloques-4
    pos_ant3 = son(i-3);
    pos_ant2 = son(i-2);
    pos_ant1 = son(i-1);
    pos_actual = son(i);
    pos_sig1 = son(i+1);

    if ((pos_ant3==1)&&(pos_ant2==1)&&(pos_ant1==1)...
           &&(pos_actual==0)&&...
           (pos_sig1==1))
            rellenado(i)=1;
    end
end
end