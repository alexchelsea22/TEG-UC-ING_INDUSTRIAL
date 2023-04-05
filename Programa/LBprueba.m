function [ output ] = LBprueba ( A,alpha )

%Prueba Ljung-Box (Independencia categoría 1)

[x,y]=size(A);

v=estLB(A);

b=(x/3);

m=round(b);

gl=[];

for j=1:y
    
    gl=[gl;m];
    
end

pvalor= [];

for k=1:y
        
        pvalor = [pvalor;(1-chi2cdf(v(k),m))];  
    
end

        numv=(1:y); 
        esta=v';
        gl1=gl';
        pvv=(pvalor)';
        
        table=[numv;esta;gl1;pvv];
         
disp(' ');
disp('Tabla resumen de la Prueba Ljung-Box (Independencia categoría 1)')
disp(' ');
disp(['              [Numero de observaciones = ',num2str(x) ', ' 'Longitud del rezago (Lag) = ',num2str(m) ']']);
fprintf('     -------------------------------------------------------------------------------\n');
disp('          Serie de Tiempo        Estadísticos de prueba         G.L.          P       ')
disp('           (o variable)                                                       ')
fprintf('     -------------------------------------------------------------------------------\n');
fprintf('%18.0f %28.4f %18.0f %15.4f  \n',table);
fprintf('     -------------------------------------------------------------------------------\n');
disp(' ');
fprintf('Con un nivel de significancia de: %.3f\n', alpha);
            
output=[];

for l=1:y
    
    if pvalor(l)<= alpha
        
        disp(' ');
        fprintf('Se rechaza Ho, es decir, los datos de la serie de tiempo %.f no son independientes.\n', l);
                
        output=[output;1];
        
    else
        
        disp(' ');
        fprintf('No se rechaza Ho, es decir, los datos de la serie de tiempo %.f son independientes.\n', l);
        
        output=[output;0];
         
    end
    
end

disp(' ');

end

