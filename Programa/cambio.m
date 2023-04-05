function [ output ] = cambio( x,n,p )

%Programa para estimar el punto de cambio

maximo=0;

for i=(p+1):(n-p-1)
    
    ggkn=estGkn(x,p,n,i);
    
    if ggkn>maximo
        
        maximo=ggkn;
        
        output=i;
    end
    
end
     
end

