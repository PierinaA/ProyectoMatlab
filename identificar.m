function letras = identificar(x_test,RL,pos_medio)

num_vocales_identificar = length(pos_medio);
letras = char(zeros(1,num_vocales_identificar));

for i=1:num_vocales_identificar

    sal_a = x_test(i,:)*RL.a;
    sal_e = x_test(i,:)*RL.e;
    sal_i = x_test(i,:)*RL.i;
    sal_o = x_test(i,:)*RL.o;
    sal_u = x_test(i,:)*RL.u;
    
    sal_total = [sal_a;sal_e;sal_i;sal_o;sal_u];

    pred = find(sal_total==max(sal_total));
    if (length(pred)>1)
        pred = pred(1);
    end
    switch pred
        case 1
            letras(i)='a';
        case 2
            letras(i)='e';
        case 3
            letras(i)='i';
        case 4
            letras(i)='o';
        case 5
            letras(i)='u';
    end
end