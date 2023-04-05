function [ a ] = solucion( A,p )

%Programa para la determinaci�n de las ra�ces o autovalores de la ecuaci�n 
%caracter�stica de un modelo VAR(p).

v=mland(A,p);

v1=det(v);

v2=simplify(v1);

v3=[];

v3=[v3,solve(v2)];

a=double(v3);

end

