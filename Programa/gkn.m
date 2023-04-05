function [ cbartlett ] = gkn( p,m,i )

%Programa para determinar la correción de Bartlett.

exp1=(p*(log10(2)+((m-1)*log10(m-1))-((m-i-1)*log10(m-i-1))-((i-1)*log10(i-1))));

contador=0;

for j=1:p
    
    contador=(contador+(((m-1)*psi((m-j)/2))-((i-1)*psi((i-j)/2))-((m-i-1)*psi((m-i-j)/2))));
end

cbartlett=(exp1+contador);

end

