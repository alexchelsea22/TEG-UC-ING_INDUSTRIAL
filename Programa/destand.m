function [ output ] = destand( A )

%Programa para la determinación de las distancias estandarizadas 
%(distancia mahalanobis al cuadrado), de cada observación al vector 
%de medias.

[x,y]=size(A);

output=[];

for i=1:x
    
    v=(A(i,:)-(mean(A)));
    
    v1=(cov(A)^(-1));
    
    v2=(v*v1);
    
    v3=(v2*v');
    
    output=[output;v3];

end

end

