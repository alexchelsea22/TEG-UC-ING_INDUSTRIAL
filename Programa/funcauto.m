function [ output ] = funcauto( A,k )

%Programa para obtener la función de autocorrelación muestral, de cada
%componente univariante en una serie de tiempo multivariante.

b=A';

[x,y]=size(b);

varian=[];

for i=1:x
    
    varian=[varian;var(b(i,:))];
       
end

varian1=((y-1)*(varian));

media=mean(A)';

covari=[];

for j=1:x
    
    acum=0;
    
    for l=1:(y-k)
    
    acum=(acum+((b(j,l)-media(j))*(b(j,(l+k))-media(j))));
    
    end
       
    covari=[covari;acum];
    
end

output=[];

for z=1:x
    
    output=[output;(covari(z)/varian1(z))];
       
end

end

