function [out] = margoline( A,alpha)

%Prueba estadística de schwager y margolin para el problema general de  
%outliers en una muestra aleatoria normal multivariante con media 
%deslizada.

[n,y]=size(A);

if n<50
    
    disp(' ');
    disp('ADVERTENCIA: el Tamaño de la muestra es menor a 50,');
    b=input('¿Desea continuar?: No(0), Si(Cualquier otro número) ');
    
    if b==0
        
        out=2;
    
    else
        
        c=destand(A)';

        if isnan(max(c))==1 || isinf(max(c))==1
    
            out=3;
                    
        else
        
            c1=(1:n);

            table=[c1;c];
        
disp(' ');
fprintf('                       -----------------------------------------------\n');
disp('                        Observación Numero  Distancias Estandarizadas                  ')
fprintf('                       -----------------------------------------------\n');
fprintf('%33.0f %26.4f \n',table);
fprintf('                       -----------------------------------------------\n');
disp(' ');
fprintf('Con un nivel de significancia de: %.3f\n', alpha);
    
            est=estm(A);
            b2p=curtosis(A);
            valorp=(1-normcdf(est)); 

                if est>=norminv(1-alpha)
                
                    fprintf('La curtosis multivariante es significativa.\n'); 
                    fprintf('Valor P de la prueba: %.4f\n', valorp);
                    fprintf('Estimación de la curtosis multivariante: %.4f\n', b2p);
                    disp(' ');
                    fprintf('Conclusión: Se rechaza Ho, es decir, se presentan valores\n');
                    fprintf('atípicos en la muestra.\n');
                    disp(' ');
                    out =1;
            
                else
                
                    fprintf('La curtosis multivariante no es significativa.\n');
                    fprintf('Valor P de la prueba: %.4f\n', valorp);
                    fprintf('Estimación de la curtosis multivariante: %.4f\n', b2p);
                    disp(' ');
                    fprintf('Conclusión: No se rechaza Ho, es decir, no se presentan valores\n');
                    fprintf('atípicos en la muestra.\n');
                    disp(' ');
                    out =0;
            
                end
        end
        
   end
        
else
    
    c=destand(A)';

    if isnan(max(c))==1 || isinf(max(c))==1
    
        out=3;
                    
    else
    
        c1=(1:n);

        table=[c1;c];
        
disp(' ');
fprintf('                       -----------------------------------------------\n');
disp('                        Observación Numero  Distancias Estandarizadas                  ')
fprintf('                       -----------------------------------------------\n');
fprintf('%33.0f %26.4f \n',table);
fprintf('                       -----------------------------------------------\n');
disp(' ');
fprintf('Con un nivel de significancia de: %.3f\n', alpha);
    
            est=estm(A);
            b2p=curtosis(A);
            valorp=(1-normcdf(est)); 
        
            if est>=norminv(1-alpha)
                
                fprintf('La curtosis multivariante es significativa.\n'); 
                fprintf('Valor P de la prueba: %.4f\n', valorp);
                fprintf('Estimación de la curtosis multivariante: %.4f\n', b2p);
                disp(' ');
                fprintf('Conclusión: Se rechaza Ho, es decir, se presentan valores\n');
                fprintf('atípicos en la muestra.\n');
                disp(' ');
                out =1;
            
            else
                
                fprintf('La curtosis multivariante no es significativa.\n');
                fprintf('Valor P de la prueba: %.4f\n', valorp);
                fprintf('Estimación de la curtosis multivariante: %.4f\n', b2p);
                disp(' ');
                fprintf('Conclusión: No se rechaza Ho, es decir, no se presentan valores\n');
                fprintf('atípicos en la muestra.\n');
                disp(' '); 
                out =0;  
            
            end
            
    end
        
end
 
end

