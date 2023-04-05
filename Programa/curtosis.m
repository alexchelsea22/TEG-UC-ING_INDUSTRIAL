function [ output ] = curtosis( A )

%Programa para estimar la curtosis multivariante.

[x,y]=size(A);

output=0;

for i=1:x
    
    v=(A(i,:)-(mean(A)));
    
    v1=(cov(A,1)^(-1));
    
    v2=(v*v1);
    
    v3=((v2*v')^2);
    
    output=(output+(v3/x));

end

end

