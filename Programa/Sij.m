function [ S ] = Sij( x,m,i )

%Programa para estimar la matriz de covarianza.

Me=[];

for k=(i+1):m
    
    Me=[Me;x((k),:)];

end

S=cov(Me,1);

end

