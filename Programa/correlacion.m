function [ output ] = correlacion( x,m,i )

%Programa para estimar la matriz de correlación.

Me=[];

for k=(i+1):m
    
    Me=[Me;x((k),:)];

end

output=corrcoef(Me);

end

