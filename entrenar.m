function rl = entrenar(es,no_es1,no_es2,no_es3,no_es4)
x = [es;no_es1;no_es2;no_es3,;no_es4];

[Fc,~] = size(es);
[Ft,~] = size(x);

%Proceso de codificacion de vocales a numero
y = zeros(Ft,1);
y(1:Fc)=1;

rl = regress(y,x);

end