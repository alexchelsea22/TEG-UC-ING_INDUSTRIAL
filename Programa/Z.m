function [ C ] = Z( A,p )

%Programa para compactar los regresores de un modelo VAR(p).

[x,y]=size(A);

d=A';

C=[];

for i=1:(x-p)
    
    j=(i+p-1);
    E=[1];
    for k=j:-1:i
        
        v=d(:,k);
        
        E=[E;v];
        
    end
    
    C=[C,E];
    
end

C;

end

