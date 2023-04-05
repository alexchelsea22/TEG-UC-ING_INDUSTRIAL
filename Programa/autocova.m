function [ output ] = autocova( A,h )

%Programa para estimar la matriz de autocovarianzas de una serie de 
%tiempo múltiple.

[t,z]=size(A);

media=mean(A);

y=A';

output1=0;

for j=1:(t-h)
    
    output1=(output1+((y(:,(j+h))-media')*(y(:,j)-media')'));
    
end

output=((1/(t-1))*(output1));

end

