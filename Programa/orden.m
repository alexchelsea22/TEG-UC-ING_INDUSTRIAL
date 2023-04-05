function [ p,vallog ] = orden( A,alpha )

%Programa para estimar el orden autorregresivo del modelo. 

a=(A');

[x,y]=size(a);

for i=1:(y-1)
    
    if hipotesis(A,i,alpha)==1 
                   
        j=i;
                
        for k=1:j
            
            if lamvar(A,j,k)>chi2inv((1-alpha),(x^2)) 
                       
                p=(j-k+1);
                
                vallog=1;
        
                break;
                
            end
            
        end
        
        break;
        
    end 

    if hipotesis(A,i,alpha)==0 
        
        p=0;
        
        vallog=0;
        
    end
    
    if hipotesis(A,i,alpha)==2 
        
        p=0;
        
        vallog=2;
        
    end
    
end

end

