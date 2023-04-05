function [ v3 ] = producto2( A,p )

%Programa para determinar la expresión 2 del método de mínimos cuadrados.

v2=0;

[x,y]=size(A);

for k=1:(x-p)
    
    v2=(v2+(Xt(A,p,(k-1))*(Xt(A,p,(k-1))')));
    
end

v3=(v2^(-1));

end

