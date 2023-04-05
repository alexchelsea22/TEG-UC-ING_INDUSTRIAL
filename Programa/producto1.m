function [ v1 ] = producto1( A,p )

%Programa para determinar la expresión 1 del método de mínimos cuadrados.

v1=0;

[x,y]=size(A);

for k=1:(x-p)
    
    v1=(v1+(Xt(A,p,k)*(Xt(A,p,(k-1))')));
    
end

end

