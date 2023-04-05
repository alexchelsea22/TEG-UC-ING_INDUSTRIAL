function CEPM
clear

fprintf('-------------------------------------------------------------------------------------------\n');
disp('Control estadístico multivariante de procesos: programa para el monitoreo de un vector de')
disp('características de calidad.')
disp(' ');
disp('Trabajo Especial de Grado titulado: DESARROLLO DE UNA HERRAMIENTA COMPUTARIZADA PARA EL')
disp('CONTROL ESTADÍSTICO MULTIVARIANTE DE PROCESOS BASADA EN EL ANÁLISIS DE PUNTO DE CAMBIO.')
disp('18 de enero de 2015, diseñado por Ronald Medina y B r e a , Escuela de Ingeniería')
disp('Industrial, Facultad de Ingeniería, Universidad de Carabobo.')
disp('E-mail: alexchelsea222@gmail.com')
disp(' ');
disp('Este programa le permite monitorear muestras tomadas secuencialmente en el tiempo y,')
disp('estima un punto de cambio (en el caso que exista) en un proceso bajo control')
disp('estadístico, es decir, realiza el análisis de Fase II del SPC.')
fprintf('-------------------------------------------------------------------------------------------\n');
disp('Antes de iniciar el análisis de Fase II, se debe analizar un conjunto de datos históricos,')
disp('es decir, se debe efectuar un análisis de Fase I.')
disp(' ');
disp('Las pruebas de hipótesis estadísticas a realizar en el análisis de Fase I son:')
disp(' ');
disp('*Prueba de Schwager y Margolin para la detección de outliers.')
disp(' ');
disp('*Prueba de normalidad multivariante de Mardia.')
disp(' ');
disp('*Prueba de raíz unitaria de Fountis-Dickey.')
disp(' ');
disp('*Prueba de Ljung-Box y la versión multivariante de Chitturi y Hosking de la prueba de')
disp('Portmanteau.')
disp(' ');
disp('SUGERENCIA: la prueba de Schwager y Margolin y prueba de Mardia dan valores críticos')
disp('conservadores para tamaños de muestra mayores o iguales a 50.')
b=input('¿Desea realizar el análisis de Fase I?: No(0), Si(Cualquier otro número) ');

if b==0
    
fprintf('-------------------------------------------------------------------------------------------\n');
disp('La herramienta estadística utilizada para el análisis de Fase II, es un gráfico de control');
disp('basado en el Análisis de Punto de Cambio (CPA).')

%Lectura de datos Fase II.

[t,m,datos]=lecturafaseII;

matr1=datos;

%Verificando que los datos no provengan de procesos univariantes.

if m==1
    
disp(' ');
disp('ERROR: LOS DATOS NO SON VECTORES DE OBSERVACIÓN, ES DECIR, NO ESTÁ MONITOREANDO UN VECTOR')
disp('DE CARACTERÍSTICAS DE CALIDAD.')
disp(' ');

else
    
%Verificando que el p este en el rango.

if m==2 || m==3 || m==4 || m==5 || m==10 || m==15 || m==20 || m==25
    
%Verificando que el tamaño de muestra sea mayor o igual a 2(p+1).
    
if t<(2*(m+1))
          
disp(' ');
disp('ERROR: EL TAMAÑO DE MUESTRA ES MENOR AL MÍNIMO REQUERIDO.')
disp(' ');

else  

%Construcción del grafico de control.

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuación se procederá a construir el Gráfico de Control del CPA.')
disp(' ');
disp('Deberá indicar el nivel significancia alfa (probabilidad especificada de emitir una falsa')
disp('alarma), cuando se le indique.')
disp(' ');
disp('Valores permitidos de alfa: 0.0005 0.001 0.002 0.005 0.01')
alp5=input('Indique el valor de alfa: ');
Vcrit=hdehawkins(t,m,alp5);

    %Gmax,n
    
    GMaxi=estGknmax(matr1,m,t);

    %Verificando un posible punto de cambio.
    
    bandn1=false;
    
    for j=(2*(m+1)):t
        
        if GMaxi(j)>Vcrit(j) && bandn1==false
            
            pcam=cambio(matr1,j,m);
                        
            fprintf('-------------------------------------------------------------------------------------------\n');
            disp('Vector de medias, matriz de covarianzas y matriz de correlaciones muestral antes del cambio:')
            disp(' ');
            disp('*Vector de medias:')
            parm=vectmedia(matr1,pcam,0);
            disp(parm)
            disp('*Matriz de covarianzas:')
            parm1=Sij(matr1,pcam,0);
            disp(parm1)
            disp('*Matriz de correlaciones:')
            parm2=correlacion(matr1,pcam,0);
            disp(parm2)
            fprintf('-------------------------------------------------------------------------------------------\n');
            disp('Vector de medias, matriz de covarianza y matriz de correlaciones muestral después del cambio:')
            disp(' ');
            disp('*Vector de medias:')
            parm3=vectmedia(matr1,t,pcam);
            disp(parm3)
            disp('*Matriz de covarianzas:')
            parm4=Sij(matr1,t,pcam);
            disp(parm4)
            disp('*Matriz de correlaciones:')
            parm5=correlacion(matr1,t,pcam);
            disp(parm5)
            disp('Existe suficiente evidencia estadística para afirmar, que ha ocurrido un cambio en el')
            disp(['vector de medias, matriz de covarianzas o en ambos, en n igual a: ', num2str(j)]) 
            disp(' ');
            disp(['El punto estimado en donde ocurre el cambio es en la observación: ', num2str(pcam)]) 
            disp(' ');
            disp('Conclusión: el proceso está fuera de control, es decir, el proceso está operando en presencia')
            disp('de causas asignables de variación.')
            disp(' ');
            disp('Arriba se presentan los vectores de medias, matrices de covarianzas y matrices de correlaciones')
            disp('muestral, antes y después del cambio.')
            
            bandn1=true;
            
        end
                
    end
    
    if bandn1==false
    
        fprintf('-------------------------------------------------------------------------------------------\n');
        disp('Estimaciones del vector de medias, matriz de covarianzas y matriz de correlaciones:')
        disp(' ');
        disp('*Vector de medias:')
        parm6=vectmedia(matr1,t,0);
        disp(parm6)
        disp('*Matriz de covarianzas:')
        parm7=Sij(matr1,t,0);
        disp(parm7)
        disp('*Matriz de correlaciones:')
        parm8=correlacion(matr1,t,0);
        disp(parm8)
        disp('No existe suficiente evidencia estadística para afirmar, que ha ocurrido un cambio en el')
        disp('vector de medias, matriz de covarianzas o en ambos.')
        disp(' ');
        disp('Conclusión: el proceso está bajo control estadístico, es decir, el proceso opera únicamente')
        disp('en presencia de causas fortuitas de variación.')
        disp(' ');
        disp('Arriba se presentan las estimaciones del vector de medias, matriz de covarianzas y matriz de')
        disp('correlaciones.')
        
    end
    
    %Gráfico de control
    
graficodecontrol=[GMaxi;Vcrit];

XxX=(1:t);

yminimo=min(min(graficodecontrol));
ymaximo=max(max(graficodecontrol)); 
plot(XxX, GMaxi, XxX, Vcrit)
title('GRÁFICA DE CONTROL DEL ANÁLISIS DE PUNTO DE CAMBIO.')
axis([(2*(m+1)) t yminimo ymaximo])
xlabel('MUESTRAS' )
ylabel('Gmax,n' )
grid on
legend('Gmax,n','Límite de Control h');
datacursormode on 
       
end

else
    
%En el caso que no se encuentre disponible la dimensión del vector.
   
disp(' ');
disp('ERROR: el grafico de control no puede ser construido, debido a que no')
disp('se encuentra disponible la dimensión de su vector de observación.')
disp(' ');

end

end

else
    
%lectura de datos de la Fase I

[n,p,dat]=lecturafaseI;

matr=dat;

%Verificando que los datos no provengan de procesos univariantes.

if p==1
    
disp(' ');
disp('ERROR: LOS DATOS NO SON VECTORES DE OBSERVACIÓN, ES DECIR, NO ESTÁ MONITOREANDO UN VECTOR')
disp('DE CARACTERÍSTICAS DE CALIDAD.')
disp(' ');

else

%Datos Atípicos (Outliers)

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuación se realizará la Prueba de Schwager y Margolin para la detección de outliers,')
disp('con el fin de depurar los datos para el Análisis de Fase I.')
disp(' ');
AUT=input('¿Desea aplicar esta prueba?: No(0), Si(Cualquier otro número) ');
disp(' ');

    %Realizo la prueba de outliers
    
if AUT~=0
    
    alp=input('Indique el nivel de significancia alfa: ');
    
    condi=margoline(matr,alp);
    
    if condi==3
        
        disp(' ');
        disp('La matriz de covarianzas muestral de los datos es singular.')
        disp('SI SELECCIONA SI, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
        sing=input('¿Desea probar con otra data?: No(0), Si(Cualquier otro número) ');
        
        if sing~=0
            
            return
            
        end
        
    elseif condi==1
        
        disp(' ');
        disp('Para la eliminación de valores atípicos (outliers), elimine las observaciones con')
        disp('distancias estandarizadas grandes.')
        disp(' ');
        disp('Ingrese el nombre del archivo Excel, que contiene los datos depurados de valores atípicos')
        disp('cuando se le indique. ');
        disp(' ');
        filename=input('Ingrese el nombre del archivo: ','s');
        matr=xlsread(filename); %Cambiara solo si hay ouliers
        
    elseif condi==0
        
        disp('*PRESIONE CUALQUIER TECLA PARA CONTINUAR.') %Pausa
        pause
        
    end
    
end

%Prueba de Mardia

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuación se realizará la Prueba de normalidad multivariante de Mardia, con el objeto de')
disp('validar el supuesto de normalidad multivariante.')
disp(' ');
AUT1=input('¿Desea aplicar esta prueba?: No(0), Si(Cualquier otro número) ');
disp(' ');

if AUT1~=0
    
    alp1=input('Indique el nivel de significancia alfa: ');
      
    condi1=mardia( matr,alp1 );
    
     if condi1==3
        
        disp(' ');
        disp('La matriz de covarianzas muestral de los datos es singular.')
        disp('SI SELECCIONA SI, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
        sing1=input('¿Desea probar con otra data?: No(0), Si(Cualquier otro número) ');
        
        if sing1~=0
            
            return
            
        end
        
     elseif condi1==0
         
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
        nnor=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro número) ');
        
        if nnor==0
            
            return
            
        end
    
    elseif condi1==1
        
        disp('*PRESIONE CUALQUIER TECLA PARA CONTINUAR.') %Pausa
        pause
        
     end
     
end
  
%Prueba de Fountis-Dickey

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuación se realizará la Prueba de raíz unitaria de Fountis-Dickey, la cual examina')
disp('la existencia de una raíz unitaria en una serie de tiempo multivariante autorregresiva.')
disp(' ');
AUT2=input('¿Desea aplicar esta prueba?: No(0), Si(Cualquier otro número) ');
disp(' ');

if AUT2~=0
    
    disp('Valores permitidos de alfa: ')
    disp('0.01 0.05 0.1')
    alp2=input('Indique el nivel de significancia alfa: ');
      
    condi2= pruebafd( matr,alp2 );

    if condi2==3
        
        disp(' ');
        disp('La prueba de Fountis-Dickey ha fallado debido a la presencia de matrices singulares,')
        disp('el supuesto de estacionariedad en amplio sentido no puede ser validado.');
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
        sing2=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro número) ');
        
        if sing2==0
            
            return
            
        end
    
    elseif condi2==4
        
        disp(' ');
        disp('La prueba de Fountis-Dickey ha fallado, debido a que el orden del modelo autorregresivo')
        disp('vectorial VAR(p), no ha podido ser estimado.');
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
        noord=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro número) ');
        
        if noord==0
            
            return
            
        end
        
    elseif condi2==2
        
        disp(' ');
        disp('La prueba de Fountis-Dickey ha fallado, debido a que ha ingresado un alfa fuera de los')
        disp('permitidos.');
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
        noalfa=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro número) ');
        
        if noalfa==0
            
            return
            
        end
        
    elseif condi2==0
        
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
        noesta=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro número) ');
        
        if noesta==0
            
            return
            
        end
        
    elseif condi2==5
        
        disp(' ');
        disp('La prueba de Fountis-Dickey ha fallado, debido a que la serie de tiempo')
        disp('multivariante es explosiva.');
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
        explosiva=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro número) ');
        
        if explosiva==0
            
            return
            
        end
       
    elseif condi2==1
        
        disp('*PRESIONE CUALQUIER TECLA PARA CONTINUAR.') %Pausa
        pause 
        
    end
    
end

%Evaluación de la Independencia.

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuación se probará la independencia de los datos.')
disp('Este análisis es divido en dos categorías:')
disp(' ');
disp('*CATEGORÍA I: prueba la independencia en cada componente univariante de la serie de')
disp('tiempo multivariante.');
disp(' ');
disp('*CATEGORÍA II: prueba la existencia de una dependencia lineal dinámica en los datos de')
disp('la serie de tiempo multivariante.')
disp(' ');
disp('CATEGORÍA I: Prueba de Ljung-Box');
disp(' ');
AUT3=input('¿Desea aplicar esta prueba?: No(0), Si(Cualquier otro número) ');
disp(' ');

if AUT3~=0
    
    alp3=input('Indique el nivel de significancia alfa: ');
      
    condi3=LBprueba(matr,alp3);

    [tam,tam1]=size(condi3); %Tamaño del vector
    
    bandn=false;
    
    for i=1:tam
        
        if condi3(i)==1 && bandn==false
            
            bandn=true;
            
        end
        
    end
       
    disp('*PRESIONE CUALQUIER TECLA PARA CONTINUAR.') %Pausa
    pause  
      
end  

disp(' ');
disp('CATEGORÍA II: Versión multivariante de Chitturi y Hosking de la prueba de Portmanteau.');
disp('En esta categoría se prueba la existencia de una dependencia lineal dinámica en los datos de')
disp('la serie de tiempo multivariante.')
disp(' ');
AUT4=input('¿Desea aplicar esta prueba?: No(0), Si(Cualquier otro número) ');
disp(' ');

if AUT4~=0
           
    alp4=input('Indique el nivel de significancia alfa: ');
    
    condi4=portmprueba(matr,alp4);
    
    if condi4==2
       
        disp(' ');
        disp('La matriz de covarianzas muestral de los datos es singular.')
        disp('SI SELECCIONA SI, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
        sing3=input('¿Desea probar con otra data?: No(0), Si(Cualquier otro número) ');
        
        if sing3~=0
            
            return
            
        end
        
    end
    
end

    %Decisión de la prueba de Independencia

if AUT3~=0 && AUT4~=0
        
if bandn==true && condi4==1
    
    disp(' ');
    disp('Los datos son independientes solo en la categoría II.')
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
    ind=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro número) ');
        
        if ind==0
            
            return
            
        end
    
elseif bandn==false && condi4==0
    
    disp(' ');
    disp('Los datos son independientes solo en la categoría I.')
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
    ind1=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro número) ');
        
        if ind1==0
            
            return
            
        end
        
elseif bandn==true && condi4==0
    
    disp(' ');
    disp('Los datos no son independientes en ambas categorías.')
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
    ind2=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro número) ');
        
        if ind2==0
            
            return
            
        end
        
elseif bandn==false && condi4==1
    
    disp('*PRESIONE CUALQUIER TECLA PARA CONTINUAR.') %Pausa
    pause  
        
end

elseif AUT3==0 && AUT4~=0
    
    disp('No se puede tomar una decisión con respecto a la independencia, debido a que no se ejecutaron')
    disp('las pruebas de independencia para ambas categorías.')
    disp(' ');
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
    ind3=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro numero) ');
        
        if ind3==0
            
            return
            
        end

elseif AUT3~=0 && AUT4==0
    
    disp('No se puede tomar una decisión con respecto a la independencia, debido a que no se ejecutaron')
    disp('las pruebas de independencia para ambas categorías.')
    disp(' ');
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDRÁ SU EJECUCIÓN.')
    ind4=input('¿Desea continuar con el análisis?: No(0), Si(Cualquier otro numero) ');
        
        if ind4==0
            
            return
            
        end

end

fprintf('-------------------------------------------------------------------------------------------\n');
disp('Ha finalizado el análisis de Fase I.')
disp(' ');
disp('A CONTINUACIÓN INICIARA EL ANÁLISIS DE FASE II.')
disp(' ');
disp('La herramienta estadística utilizada para el análisis es un gráfico de control basado en el');
disp('Análisis de Punto de Cambio (CPA).')
disp(' ');
disp('*PRESIONE CUALQUIER TECLA PARA CONTINUAR.') %Pausa
pause  
        
%Lectura de datos Fase II.

[t,m,datos]=lecturafaseII;

matr1=datos;

%Verificando que los datos no provengan de procesos univariantes.

if m==1
    
disp(' ');
disp('ERROR: LOS DATOS NO SON VECTORES DE OBSERVACIÓN, ES DECIR, NO ESTÁ MONITOREANDO UN VECTOR')
disp('DE CARACTERÍSTICAS DE CALIDAD.')
disp(' ');

else
    
%Verificando que el p este en el rango

if m==2 || m==3 || m==4 || m==5 || m==10 || m==15 || m==20 || m==25
    
%Verificando que el tamaño de muestra sea mayor o igual a 2(p+1).
    
if t<(2*(m+1))
          
disp(' ');
disp('ERROR: EL TAMAÑO DE MUESTRA ES MENOR AL MÍNIMO REQUERIDO.')
disp(' ');

else  
    
%Construcción del grafico de control.

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuación se procederá a construir el Gráfico de Control del CPA.')
disp(' ');
disp('Deberá indicar el nivel significancia alfa (probabilidad especificada de emitir una falsa')
disp('alarma), cuando se le indique.')
disp(' ');
disp('Valores permitidos de alfa: 0.0005 0.001 0.002 0.005 0.01')
alp5=input('Indique el valor de alfa: ');
Vcrit=hdehawkins(t,m,alp5);

    %Gmax,n
    
    GMaxi=estGknmax(matr1,m,t);

    %Verificando un posible punto de cambio.
    
    bandn1=false;
    
    for j=(2*(m+1)):t
        
        if GMaxi(j)>Vcrit(j) && bandn1==false
            
            pcam=cambio(matr1,j,m);
                        
            fprintf('-------------------------------------------------------------------------------------------\n');
            disp('Vector de medias, matriz de covarianzas y matriz de correlaciones muestral antes del cambio:')
            disp(' ');
            disp('*Vector de medias:')
            parm=vectmedia(matr1,pcam,0);
            disp(parm)
            disp('*Matriz de covarianzas:')
            parm1=Sij(matr1,pcam,0);
            disp(parm1)
            disp('*Matriz de correlaciones:')
            parm2=correlacion(matr1,pcam,0);
            disp(parm2)
            fprintf('-------------------------------------------------------------------------------------------\n');
            disp('Vector de medias, matriz de covarianzas y matriz de correlaciones muestral después del cambio:')
            disp(' ');
            disp('*Vector de medias:')
            parm3=vectmedia(matr1,t,pcam);
            disp(parm3)
            disp('*Matriz de covarianzas:')
            parm4=Sij(matr1,t,pcam);
            disp(parm4)
            disp('*Matriz de correlaciones:')
            parm5=correlacion(matr1,t,pcam);
            disp(parm5)
            disp('Existe suficiente evidencia estadística para afirmar, que ha ocurrido un cambio en el')
            disp(['vector de medias, matriz de covarianzas o en ambos, en n igual a: ', num2str(j)]) 
            disp(' ');
            disp(['El punto estimado en donde ocurre el cambio es en la observación: ', num2str(pcam)]) 
            disp(' ');
            disp('Conclusión: el proceso está fuera de control, es decir, el proceso está operando en presencia')
            disp('de causas asignables de variación.')
            disp(' ');
            disp('Arriba se presentan los vectores de medias, matrices de covarianzas y matrices de correlaciones')
            disp('muestral, antes y después del cambio.')
            
            bandn1=true;
            
        end
                
    end
    
    if bandn1==false
    
        fprintf('-------------------------------------------------------------------------------------------\n');
        disp('Estimaciones del vector de medias, matriz de covarianzas y matriz de correlaciones:')
        disp(' ');
        disp('*Vector de medias:')
        parm6=vectmedia(matr1,t,0);
        disp(parm6)
        disp('*Matriz de covarianzas:')
        parm7=Sij(matr1,t,0);
        disp(parm7)
        disp('*Matriz de correlaciones:')
        parm8=correlacion(matr1,t,0);
        disp(parm8)
        disp('No existe suficiente evidencia estadística para afirmar, que ha ocurrido un cambio en el')
        disp('vector de medias, matriz de covarianzas o en ambos.')
        disp(' ');
        disp('Conclusión: el proceso está bajo control estadístico, es decir, el proceso opera únicamente')
        disp('en presencia de causas fortuitas de variación.')
        disp(' ');
        disp('Arriba se presentan las estimaciones del vector de medias, matriz de covarianzas y matriz de')
        disp('correlaciones.')
        
    end
    
    %Gráfico de control
    
graficodecontrol=[GMaxi;Vcrit];

XxX=(1:t);

yminimo=min(min(graficodecontrol));
ymaximo=max(max(graficodecontrol));
plot(XxX, GMaxi, XxX, Vcrit)
title('GRÁFICA DE CONTROL DEL ANÁLISIS DE PUNTO DE CAMBIO.')
axis([(2*(m+1)) t yminimo ymaximo])
xlabel('MUESTRAS' )
ylabel('Gmax,n' )
grid on
legend('Gmax,n','Límite de Control h');
datacursormode on
    
end

else
    
%En el caso que no se encuentre disponible la dimensión del vector.
    
disp(' ');
disp('ERROR: el grafico de control no puede ser construido, debido a que no')
disp('se encuentra disponible la dimensión de su vector de observación.')
disp(' ');
    
end

end

end

end


end

