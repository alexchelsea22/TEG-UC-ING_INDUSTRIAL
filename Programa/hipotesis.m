function [ output ] = hipotesis( A,M,alpha )

%Programa para encontrar el primer orden m, en donde la i hipótesis nula 
%es rechazada.

[a,b]=size(A);

band=false;

for i=1:M      

[c,d]=lamvar(A,M,i);
    
    if d~=0 && c>chi2inv((1-alpha),(b^2)) && band==false
        
        band=true;
        
        output=1;
        
    end 
    
    if d~=0 && c<=chi2inv((1-alpha),(b^2)) && band==false
        
        output=0;
        
    end
    
    if d==0 && band==false
        
        output=2;
        
    end 

end

end

