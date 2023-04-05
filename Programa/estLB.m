function [ output ] = estLB( A )

%Programa para obtener el estadistico de prueba del test de Ljung–Box, de 
%cada componente univariante en una serie de tiempo múltiple.

[x,y]=size(A);

a=(x/3);

m=round(a);

z=0;

for k=1:m   

    z=(z+((funcauto(A,k).^2)./(x-m)));
    
end

output=((x*(x+2))*z);

end

