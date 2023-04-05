function [ output ] = mardia( A,alpha )

%Prueba de normalidad multivariante de Mardia.

[T,p]=size(A);
    
if T<50
    
    disp(' ');
    disp('ADVERTENCIA: el Tamaño de la muestra es menor a 50,');
    b=input('¿Desea continuar?: No(0), Si(Cualquier otro número) ');
        
    if b==0
            
        output=2;
            
    else
            
        asim=asimetria(A);
            
        if isnan(asim)==1 || isinf(asim)==1
    
            output=3;
                    
        else
            
            curt=curtosis(A);
            
            vc1=((6^(-1))*T*asim);
            
            vc2=(curt-(p*(p+2)));

            vc3=sqrt((8*p*(p+2))/T);

            vc4=(vc2/vc3);
            
            gl=((6^(-1))*p*(p+1)*(p+2));
            
            pvalor1=(1-chi2cdf(vc1,gl));
            
            pvalor2=(2*(1-normcdf(abs(vc4))));
            
            disp(' ');
            disp('Tabla resumen de la Prueba de Mardia')
            disp(['[Numero de observaciones = ',num2str(T) ', ' 'Variables = ',num2str(p) ']']);
            fprintf('-------------------------------------------------------------------------------\n');
            disp('Coeficientes                     Estimación     Estadístico      G.L.      P')
            disp('                                                 de prueba                          ')
            fprintf('-------------------------------------------------------------------------------\n');
            fprintf('Asimetría         %23.4f%16.4f%11i%11.4f\n\n',asim,vc1,gl,pvalor1);
            fprintf('Curtosis         %24.4f%16.4f%22.4f\n',curt,vc4,pvalor2);
            fprintf('-------------------------------------------------------------------------------\n');
            fprintf('Con un nivel de significancia de: %.2f\n', alpha);
            
            if pvalor1<=alpha && pvalor2<=alpha
                
                fprintf('La asimetría multivariante es significativa.\n');
                fprintf('La curtosis multivariante es significativa.\n');
                disp(' ');
                fprintf('Por lo tanto se rechaza Ho, es decir, los datos no se ajustan a una\n');
                fprintf('distribución normal multivariante.\n');
                disp(' ');
                                
                output=0;
                
            end
            
            if pvalor1>alpha && pvalor2>alpha
                
                fprintf('La asimetría multivariante no es significativa.\n');
                fprintf('La curtosis multivariante no es significativa.\n');
                disp(' ');
                fprintf('Por lo tanto No se rechaza Ho, es decir, los datos se ajustan a una\n');
                fprintf('distribución normal multivariante.\n');
                disp(' ');
                
                output=1;
                
            end
            
            if pvalor1<=alpha && pvalor2>alpha
                
                fprintf('La asimetría multivariante es significativa.\n');
                fprintf('La curtosis multivariante no es significativa.\n');
                disp(' ');
                fprintf('Por lo tanto se rechaza Ho, es decir, los datos no se ajustan a una\n');
                fprintf('distribución normal multivariante.\n');
                disp(' ');
                                
                output=0;
                
            end
        
            
            if pvalor1>alpha && pvalor2<=alpha
                
                fprintf('La asimetría multivariante no es significativa.\n');
                fprintf('La curtosis multivariante es significativa.\n');
                disp(' ');
                fprintf('Por lo tanto se rechaza Ho, es decir, los datos no se ajustan a una\n');
                fprintf('distribución normal multivariante.\n');
                disp(' ');
                                
                output=0;
                
            end
            
        end
        
    end
    
else
    
    asim=asimetria(A);
                    
    if isnan(asim)==1 || isinf(asim)==1
    
        output=3;
                    
    else
        
        curt=curtosis(A);
            
        vc1=((6^(-1))*T*asim);
            
        vc2=(curt-(p*(p+2)));

        vc3=sqrt((8*p*(p+2))/T);

        vc4=(vc2/vc3);
            
        gl=((6^(-1))*p*(p+1)*(p+2));
            
        pvalor1=(1-chi2cdf(vc1,gl));
            
        pvalor2=(2*(1-normcdf(abs(vc4))));
            
            disp(' ');
            disp('Tabla resumen de la Prueba de Mardia')
            disp(['[Numero de observaciones = ',num2str(T) ', ' 'Variables = ',num2str(p) ']']);
            fprintf('-------------------------------------------------------------------------------\n');
            disp('Coeficientes                     Estimación     Estadística      G.L.      P')
            fprintf('-------------------------------------------------------------------------------\n');
            fprintf('Asimetría         %23.4f%16.4f%11i%11.4f\n\n',asim,vc1,gl,pvalor1);
            fprintf('Curtosis         %24.4f%16.4f%22.4f\n',curt,vc4,pvalor2);
            fprintf('-------------------------------------------------------------------------------\n');
            fprintf('Con un nivel de significancia de: %.2f\n', alpha);
            
        if pvalor1<=alpha && pvalor2<=alpha
                
            fprintf('La asimetría multivariante es significativa.\n');
            fprintf('La curtosis multivariante es significativa.\n');
            disp(' ');
            fprintf('Por lo tanto se rechaza Ho, es decir, los datos no se ajustan a una\n');
            fprintf('distribución normal multivariante.\n');
            disp(' ');
                
            output=0;
                
        end
            
        if pvalor1>alpha && pvalor2>alpha
                
            fprintf('La asimetría multivariante no es significativa.\n');
            fprintf('La curtosis multivariante no es significativa.\n');
            disp(' ');
            fprintf('Por lo tanto No se rechaza Ho, es decir, los datos se ajustan a una\n');
            fprintf('distribución normal multivariante.\n');
            disp(' ');
                
            output=1;
                
        end
            
        if pvalor1<=alpha && pvalor2>alpha
                
            fprintf('La asimetría multivariante es significativa.\n');
            fprintf('La curtosis multivariante no es significativa.\n');
            disp(' ');
            fprintf('Por lo tanto se rechaza Ho, es decir, los datos no se ajustan a una\n');
            fprintf('distribución normal multivariante.\n');
            disp(' ');
                
            output=0;
                
        end
        
            
        if pvalor1>alpha && pvalor2<=alpha
                
            fprintf('La asimetría multivariante no es significativa.\n');
            fprintf('La curtosis multivariante es significativa.\n');
            disp(' ');
            fprintf('Por lo tanto se rechaza Ho, es decir, los datos no se ajustan a una\n');
            fprintf('distribución normal multivariante.\n');
            disp(' ');
                
            output=0;
                
        end
            
    end
    
end

