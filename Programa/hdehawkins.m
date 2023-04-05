function [ h ] = hdehawkins(n,p,alfa)

%Programa para la determinación del limite de control

h=zeros(n,1,'double');

switch  p

case 2
   
    for N=(2*(p+1):n)
        TabAPC=xlsread('p igual a 2');
        [nAPC,pAPC]=size(TabAPC);
        
          for i=2:nAPC
             ValAPC=TabAPC(i,1);
             
             if ValAPC==N;
                 
                 for j=2:pAPC
                    Val2APC=TabAPC(1,j);  
                    
                    if Val2APC==alfa;
                     h(N)=TabAPC(i,j);                        
                    end
                 end
             end
         end
    end
    
case 3
    
    for N=(2*(p+1):n)
        TabAPC=xlsread('p igual a 3');
        [nAPC,pAPC]=size(TabAPC);
        
          for i=2:nAPC
             ValAPC=TabAPC(i,1);
             
             if ValAPC==N;
                 
                 for j=2:pAPC
                    Val2APC=TabAPC(1,j);  
                    
                    if Val2APC==alfa;
                     h(N)=TabAPC(i,j);                        
                    end
                 end
             end
         end
    end
    
case 4
    
    for N=(2*(p+1):n)
        TabAPC=xlsread('p igual a 4');
        [nAPC,pAPC]=size(TabAPC);
        
          for i=2:nAPC
             ValAPC=TabAPC(i,1);
             
             if ValAPC==N;
                 
                 for j=2:pAPC
                    Val2APC=TabAPC(1,j);  
                    
                    if Val2APC==alfa;
                     h(N)=TabAPC(i,j);                        
                    end
                 end
             end
         end
    end
    
    
case 5
    
    for N=(2*(p+1):n)
        TabAPC=xlsread('p igual a 5');
        [nAPC,pAPC]=size(TabAPC);
        
          for i=2:nAPC
             ValAPC=TabAPC(i,1);
             
             if ValAPC==N;
                 
                 for j=2:pAPC
                    Val2APC=TabAPC(1,j);  
                    
                    if Val2APC==alfa;
                     h(N)=TabAPC(i,j);                        
                    end
                 end
             end
         end
    end
    
case 10
    
 for N=(2*(p+1):n)
        TabAPC=xlsread('p igual a 10');
        [nAPC,pAPC]=size(TabAPC);
        
          for i=2:nAPC
             ValAPC=TabAPC(i,1);
             
             if ValAPC==N;
                 
                 for j=2:pAPC
                    Val2APC=TabAPC(1,j);  
                    
                    if Val2APC==alfa;
                     h(N)=TabAPC(i,j);                        
                    end
                 end
             end
         end
 end
    
 case 15
     
 for N=(2*(p+1):n)
        TabAPC=xlsread('p igual a 15');
        [nAPC,pAPC]=size(TabAPC);
        
          for i=2:nAPC
             ValAPC=TabAPC(i,1);
             
             if ValAPC==N;
                 
                 for j=2:pAPC
                    Val2APC=TabAPC(1,j);  
                    
                    if Val2APC==alfa;
                     h(N)=TabAPC(i,j);                        
                    end
                 end
             end
         end
 end
 
 
case 20
     
 for N=(2*(p+1):n)
        TabAPC=xlsread('p igual a 20');
        [nAPC,pAPC]=size(TabAPC);
        
          for i=2:nAPC
             ValAPC=TabAPC(i,1);
             
             if ValAPC==N;
                 
                 for j=2:pAPC
                    Val2APC=TabAPC(1,j);  
                    
                    if Val2APC==alfa;
                     h(N)=TabAPC(i,j);                        
                    end
                 end
             end
         end
 end
 
 otherwise
     
     for N=(2*(p+1):n)
        TabAPC=xlsread('p igual a 25');
        [nAPC,pAPC]=size(TabAPC);
        
          for i=2:nAPC
             ValAPC=TabAPC(i,1);
             
             if ValAPC==N;
                 
                 for j=2:pAPC
                    Val2APC=TabAPC(1,j);  
                    
                    if Val2APC==alfa;
                     h(N)=TabAPC(i,j);                        
                    end
                 end
             end
          end
     end
 end

end

