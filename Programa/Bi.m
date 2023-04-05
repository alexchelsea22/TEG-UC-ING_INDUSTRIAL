function [ v ] = Bi( A,p,i )

%Programa para extraer las matrices de coeficiente de un modelo VAR(p)
%de la matriz B.

[x,y]=size(A);

c=productov(A,p);

v=c(1:y,((y*(i-1))+1):(y*i));

end

