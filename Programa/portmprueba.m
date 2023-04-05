function [ output ] = portmprueba( A,alpha )

%Prueba de portmanteau (Independencia categoría 2).

b=estpruport(A);

if isnan(b)==1 || isinf(b)==1
    
    output=2;
                    
else

[x,y]=size(A);

a=(x/3);

h=round(a);

gl=((y^2)*h);

vc=chi2inv((1-alpha),gl);

pvalor=(1-chi2cdf(b,gl));

disp(' ');
disp('      Tabla resumen de la Prueba multivariante de Portmanteau (Independencia categoría 2)')
disp(' ');
disp(['                     [Numero de observaciones = ',num2str(x) ', ' 'Rezagos (Lag) = ',num2str(h) ']']);
fprintf('                   -----------------------------------------------------\n');
disp('                        Estadístico de prueba         G.L.       P')
fprintf('                   -----------------------------------------------------\n');
fprintf('%38.4f %18.0f %10.4f \n',b,gl,pvalor);
fprintf('                   -----------------------------------------------------\n');
disp(' ');
fprintf('Con un nivel de significancia de: %.3f\n', alpha);

if b>vc
    
    disp(' ');
    fprintf('Por lo tanto se rechaza Ho, es decir, existe dependencia lineal\n');
    fprintf('dinámica en la serie de tiempo multivariante.\n');
    
    output=0;
    
else
    
    disp(' ');
    fprintf('Por lo tanto no se rechaza Ho, es decir, no existe dependencia lineal\n');
    fprintf('dinámica en la serie de tiempo multivariante.\n');
    
    output=1;
    
end

end

end

