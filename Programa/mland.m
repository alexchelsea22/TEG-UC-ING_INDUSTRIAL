function [ l ] = mland( A,p )

%Programa para la construcción de la matriz de autovalores.

[b,y]=size(A);

x=sym('x');

l1=((x^p)*eye(y));

l2=0;

for k=1:p
    
    l2=(l2+((x^(p-k))*(Bi(A,p,k))));

end

l=(l1-l2);

end

