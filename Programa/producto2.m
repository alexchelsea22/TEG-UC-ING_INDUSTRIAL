function [ v3 ] = producto2( A,p )

%Programa para determinar la expresi�n 2 del m�todo de m�nimos cuadrados.

v2=0;

[x,y]=size(A);

for k=1:(x-p)
    
    v2=(v2+(Xt(A,p,(k-1))*(Xt(A,p,(k-1))')));
    
end

v3=(v2^(-1));

end

