function [ la,valog ] = lamvar( A,M,i )

%Programa para determinar la estadística de prueba de razón de 
%verosimilitud, requerido para estimar el orden autorregresivo del modelo. 

[l1,vlog]=u(A,(M-i));

[l2,vlog1]=u(A,(M-i+1));

l3=det(l1);

l4=det(l2);

if vlog==0 || vlog1==0
    
    la=0;
    
    valog=0;
    
else
    
   if l3==0 || l4==0
    
    la=0;
    
    valog=0;
    
   else
    
    v=(A');

    [x,y]=size(v);

    t=(y-M);

    la=(t*(log(det(l1))-log(det(l2))));
    
    valog=1;
    
   end
   
end

end

