function [ v ] = Xt( A,p,t )

%Programa para compactar las observaciones de una serie de tiempo m�ltiple
%en vectores de tama�o Kpx1.

At=(A');

v=[];

for k=(p+t):-1:(t+1)
    
    v=[v;At(:,k)];
    
end

end

