function [ vp ] = productov( A,p )

%Programa para estimar por el m�todo de m�nimos cuadrados la matriz B de 
%tama�o KpxKp, de un modelo VAR(p) expresado en su forma VAR(1) 
%Kp-dimensional.

v1=producto1(A,p);

v2=producto2(A,p);

vp=(v1*v2);

end

