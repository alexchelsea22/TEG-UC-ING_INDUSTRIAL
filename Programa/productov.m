function [ vp ] = productov( A,p )

%Programa para estimar por el método de mínimos cuadrados la matriz B de 
%tamaño KpxKp, de un modelo VAR(p) expresado en su forma VAR(1) 
%Kp-dimensional.

v1=producto1(A,p);

v2=producto2(A,p);

vp=(v1*v2);

end

