function [ maxGkn ] = estGknmax( x,p,m )

%Programa para determinar el estadístico de prueba Gmax,n.

maxGkn=zeros(m,1);

for j=(2*(p+1)):m
    
    GKN=[];
    
    for i=(p+1):(j-p-1)
        
        GKN=[GKN,estGkn(x,p,j,i)];
        
    end
    
    maxGkn(j)=max(GKN);
    
end

end

