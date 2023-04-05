function [ a ] = solucion( A,p )

%Programa para la determinación de las raíces o autovalores de la ecuación 
%característica de un modelo VAR(p).

v=mland(A,p);

v1=det(v);

v2=simplify(v1);

v3=[];

v3=[v3,solve(v2)];

a=double(v3);

end

