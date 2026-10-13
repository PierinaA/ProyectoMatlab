function xr = radaptivo(x,rp,T_V,Fs)
P = T_V*Fs; %Tamaño del bloque en número de muestras
bloques = buffer(x,P); %creo una matriz donde cada fila es un bloque
[~,num_bloques] = size(bloques); %Obtengo la cantidad de bloques
xr=zeros(num_bloques*P,1); %Creo el vector de reproducción vacio

for i=1:num_bloques %Recorro bloque por bloque
    bloque_actual = bloques(:,i); %Extraigo el bloque de tamaño de ventana
    fe = max(abs(bloque_actual)); % Cálculo del factor de escala del bloque
    if (fe>0)
        entero =round(bloque_actual*((2^(rp-1))-1)/fe); % Cuantización del bloque a un rp fijo
        reproducible = entero*fe/((2^(rp-1))-1);        % Descuantización        
        xr((i-1)*P+1:i*P) = reproducible;
    end
end
xr=xr(1:length(x));