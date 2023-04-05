function [ ue,vlogi ] = u( A,p )

%Programa para estimar por el método de máxima verosimilitud, la matriz de
%covarianza de los errores de un modelo VAR(p).

B1=B(A,p);

if isnan(max(max(B1)))==1 || isinf(max(max(B1)))==1
    
    ue=0;
    
    vlogi=0;
    
else

vlogi=1;
    
z1=Z(A,p);

y1=(A');

[a,b]=size(y1);

y2=y1(:,(p+1):b);

T=(b-p);

ue=((T^(-1))*((y2-(B1*z1))*(y2-(B1*z1))'));

end

end

