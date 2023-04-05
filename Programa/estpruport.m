function [ output ] = estpruport( A )

%Programa para determinar la estadística de prueba del test de portmanteau.

[x,y]=size(A);

a=(x/3);

h=round(a);

output1=0;

for i=1:h
    
    output1=(output1+(trace((autocova(A,i)')*(autocova(A,0)^(-1))*(autocova(A,i))*(autocova(A,0)^(-1)))));
    
end

output=(x*output1);

end

