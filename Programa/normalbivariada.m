function [ output ] = normalbivariada( n,miu,covarianzas )

media=miu;

cova=covarianzas;

R = chol(cova);

output=[];

for i=1:n
    
    z=randn(2,1);
    
    x=(media+(R*z));
    
    x2=x';
    
    output=[output;x2];
    
end

end

