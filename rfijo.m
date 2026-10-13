function y = rfijo(x,rp)
num = (2^(rp-1) -1);
ye=round(x*num); %% Vector de Enteros
y=ye./num; %% Vector de Enteros
end
