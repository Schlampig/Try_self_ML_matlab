function [delta] = Cal_threshold(z,f,N)

%�������Ŷȡ�z-score������ֲ��������������������ű߽�

delta = ( f + z*z/(2*N) + z*sqrt(f*(1-f)/N + z*z/(4*N*N)) )/(1 + z*z/N);

end