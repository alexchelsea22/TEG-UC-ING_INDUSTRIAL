function [ output ] = pruebafd( A,alpha )

%Prueba de raíz unitaria de Fountis-Dickey.

[m,n]=size(A);

[ord,logval]=orden( A,alpha );

if logval==2 
    
    output=3;
    
elseif logval==0
        
    output=4;  
    
else
    
    if ord>m
        
    output=4;  
    
    else
        
    t=(m-ord);

        switch alpha 
            
            case 0.01
               
                [x,vectorcritico]=dfcrit(1,t,1);
                
                valorcritico=vectorcritico(1);
           
            case 0.05
               
                [x,vectorcritico]=dfcrit(1,t,1);
                
                valorcritico=vectorcritico(2);
                
            case 0.1
               
                [x,vectorcritico]=dfcrit(1,t,1);
                
                valorcritico=vectorcritico(3);
                
            otherwise
                
                valorcritico=0;

        end

            if valorcritico==0
    
                output=2;
    
            else
    
                est=estpruebafd( A,ord );
    
                    if est<=0
                    
                        if est<valorcritico
        
            disp(' ');
            disp('Tabla resumen de la Prueba de Raíz Unitaria Fountis-Dickey')
            disp(['[Numero de observaciones = ',num2str(t) ', ' 'Variables = ',num2str(n) ']']);
            fprintf('-------------------------------------------------------------------------------\n');
            disp('    Orden VAR(p)                Valor Crítico             Estadístico de Prueba')
            fprintf('-------------------------------------------------------------------------------\n');
            fprintf('         %0.0f%32.4f%30.4f\n',ord,valorcritico,est);
            fprintf('-------------------------------------------------------------------------------\n');
            fprintf('Con un nivel de significancia de: %.2f\n', alpha);
                          
            fprintf('No existe una raíz unitaria.\n');
            disp(' ');
            fprintf('Por lo tanto se rechaza Ho, es decir, el proceso es estacionario\n');
            fprintf('en amplio sentido.\n');
            disp(' ');
        
        
            output=1;
        
                        else
            
            disp(' ');
            disp('Tabla resumen de la Prueba de Raíz Unitaria Fountis-Dickey')
            disp(['[Numero de observaciones = ',num2str(t) ', ' 'Variables = ',num2str(n) ']']);
            fprintf('-------------------------------------------------------------------------------\n');
            disp('    Orden VAR(p)                Valor Crítico             Estadístico de Prueba')
            fprintf('-------------------------------------------------------------------------------\n');
            fprintf('         %0.0f%32.4f%30.4f\n',ord,valorcritico,est);
            fprintf('-------------------------------------------------------------------------------\n');
            fprintf('Con un nivel de significancia de: %.2f\n', alpha);
                          
            fprintf('Existe una raíz unitaria.\n');
            disp(' ');
            fprintf('Por lo tanto No se rechaza Ho, es decir, el proceso no es estacionario\n');
            fprintf('en amplio sentido.\n');
            disp(' ');
        
        
            output=0;
            
                        end
        
                    else
                    
            output=5;
                              
                    end
            end
            
    end
        
end
    
end

