function [ output ] = asimetria( A )

%Programa para estimar la asimetría multivariante.

[x,y]=size(A);

output=0;

for i=1:x
    
    for j=1:x
        
    v=(A(i,:)-mean(A));
    
    v1=(A(j,:)-mean(A));
    
    v2=(cov(A,1)^(-1));
    
    v3=(v*v2);
    
    v4=((v3*v1')^3);
    
    output=(output+(v4/(x^2)));
    
    end
    
end
    
end

