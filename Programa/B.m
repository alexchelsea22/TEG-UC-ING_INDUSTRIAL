function [ Be ] = B( A,p )

%Programa para estimar por el método de mínimos cuadrados, las matrices de 
%coeficientes de un modelo VAR(p), requeridos para determinar el correcto
%orden VAR.

y=A';

[f,g]=size(y);

yf=y(:,(p+1):g);

z1=Z(A,p);

Be=(yf*(z1'))*((z1*(z1'))^(-1));

end

