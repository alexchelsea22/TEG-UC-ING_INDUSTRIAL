function [ w ] = estpruebafd( A,p )

%Programa para la determinaci�n de la estad�stica de prueba del test de 
%ra�z unitaria de Fountis-Dickey.

[x,y]=size(A);

v1=solucion(A,p);

[x1,y1]=size(v1);

v2=[];

for i=1:x1
          
        v2=[v2;abs(v1(i))];
        
end

f=max(v2);

w=((x-p)*(f-1));

end

