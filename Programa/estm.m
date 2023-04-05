function [ out ] = estm(A)

%Programa para determinar la estadística de prueba del test de outliers de 
%schwager y margolin. 

[n,p]=size(A);

curt=curtosis(A);
 
nume=(curt-(p*(p+2)));
 
deno=sqrt((8*p*(p+2))/n);
 
out=(nume/deno);
 
 end

