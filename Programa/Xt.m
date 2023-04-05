function [ v ] = Xt( A,p,t )

%Programa para compactar las observaciones de una serie de tiempo múltiple
%en vectores de tamaño Kpx1.

At=(A');

v=[];

for k=(p+t):-1:(t+1)
    
    v=[v;At(:,k)];
    
end

end

