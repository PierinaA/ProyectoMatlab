function valores = descriptores(senal,Fs,b_medio,T_V)

NTV = T_V*Fs;
ventana = hamming(NTV);

descriptores_audio = audioFeatureExtractor(SampleRate=Fs,Window=ventana,...
    OverlapLength=0,mfcc=true);

num_descriptores = descriptores_audio.FeatureVectorLength();
num_vocales = length(b_medio);

num_bloques = 8;
valores = zeros(num_vocales,num_bloques*num_descriptores);

for i = 1:num_vocales
    p_i_num = NTV*(b_medio(i)-4);
    p_f_num = NTV*(b_medio(i)+4);
    
    %Acá obtengo el segmento de cada vocal
    seg_audio = senal(p_i_num:p_f_num);
    
    %Acá obtengo los descriptores de la señal
    vec_caract = extract(descriptores_audio,seg_audio);
    vec_caract = vec_caract';
    valores(i,:)=[vec_caract(:)]';
end
end