function CEPM
clear

fprintf('-------------------------------------------------------------------------------------------\n');
disp('Control estad�stico multivariante de procesos: programa para el monitoreo de un vector de')
disp('caracter�sticas de calidad.')
disp(' ');
disp('Trabajo Especial de Grado titulado: DESARROLLO DE UNA HERRAMIENTA COMPUTARIZADA PARA EL')
disp('CONTROL ESTAD�STICO MULTIVARIANTE DE PROCESOS BASADA EN EL AN�LISIS DE PUNTO DE CAMBIO.')
disp('18 de enero de 2015, dise�ado por Jos� Brea y Ronald Medina, Escuela de Ingenier�a')
disp('Industrial, Facultad de Ingenier�a, Universidad de Carabobo.')
disp('E-mail: esojmbh@gmail.com / alexchelsea222@gmail.com')
disp(' ');
disp('Este programa le permite monitorear muestras tomadas secuencialmente en el tiempo y,')
disp('estima un punto de cambio (en el caso que exista) en un proceso bajo control')
disp('estad�stico, es decir, realiza el an�lisis de Fase II del SPC.')
fprintf('-------------------------------------------------------------------------------------------\n');
disp('Antes de iniciar el an�lisis de Fase II, se debe analizar un conjunto de datos hist�ricos,')
disp('es decir, se debe efectuar un an�lisis de Fase I.')
disp(' ');
disp('Las pruebas de hip�tesis estad�sticas a realizar en el an�lisis de Fase I son:')
disp(' ');
disp('*Prueba de Schwager y Margolin para la detecci�n de outliers.')
disp(' ');
disp('*Prueba de normalidad multivariante de Mardia.')
disp(' ');
disp('*Prueba de ra�z unitaria de Fountis-Dickey.')
disp(' ');
disp('*Prueba de Ljung-Box y la versi�n multivariante de Chitturi y Hosking de la prueba de')
disp('Portmanteau.')
disp(' ');
disp('SUGERENCIA: la prueba de Schwager y Margolin y prueba de Mardia dan valores cr�ticos')
disp('conservadores para tama�os de muestra mayores o iguales a 50.')
b=input('�Desea realizar el an�lisis de Fase I?: No(0), Si(Cualquier otro n�mero) ');

if b==0
    
fprintf('-------------------------------------------------------------------------------------------\n');
disp('La herramienta estad�stica utilizada para el an�lisis de Fase II, es un gr�fico de control');
disp('basado en el An�lisis de Punto de Cambio (CPA).')

%Lectura de datos Fase II.

[t,m,datos]=lecturafaseII;

matr1=datos;

%Verificando que los datos no provengan de procesos univariantes.

if m==1
    
disp(' ');
disp('ERROR: LOS DATOS NO SON VECTORES DE OBSERVACI�N, ES DECIR, NO EST� MONITOREANDO UN VECTOR')
disp('DE CARACTER�STICAS DE CALIDAD.')
disp(' ');

else
    
%Verificando que el p este en el rango.

if m==2 || m==3 || m==4 || m==5 || m==10 || m==15 || m==20 || m==25
    
%Verificando que el tama�o de muestra sea mayor o igual a 2(p+1).
    
if t<(2*(m+1))
          
disp(' ');
disp('ERROR: EL TAMA�O DE MUESTRA ES MENOR AL M�NIMO REQUERIDO.')
disp(' ');

else  

%Construcci�n del grafico de control.

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuaci�n se proceder� a construir el Gr�fico de Control del CPA.')
disp(' ');
disp('Deber� indicar el nivel significancia alfa (probabilidad especificada de emitir una falsa')
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
            disp('Vector de medias, matriz de covarianza y matriz de correlaciones muestral despu�s del cambio:')
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
            disp('Existe suficiente evidencia estad�stica para afirmar, que ha ocurrido un cambio en el')
            disp(['vector de medias, matriz de covarianzas o en ambos, en n igual a: ', num2str(j)]) 
            disp(' ');
            disp(['El punto estimado en donde ocurre el cambio es en la observaci�n: ', num2str(pcam)]) 
            disp(' ');
            disp('Conclusi�n: el proceso est� fuera de control, es decir, el proceso est� operando en presencia')
            disp('de causas asignables de variaci�n.')
            disp(' ');
            disp('Arriba se presentan los vectores de medias, matrices de covarianzas y matrices de correlaciones')
            disp('muestral, antes y despu�s del cambio.')
            
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
        disp('No existe suficiente evidencia estad�stica para afirmar, que ha ocurrido un cambio en el')
        disp('vector de medias, matriz de covarianzas o en ambos.')
        disp(' ');
        disp('Conclusi�n: el proceso est� bajo control estad�stico, es decir, el proceso opera �nicamente')
        disp('en presencia de causas fortuitas de variaci�n.')
        disp(' ');
        disp('Arriba se presentan las estimaciones del vector de medias, matriz de covarianzas y matriz de')
        disp('correlaciones.')
        
    end
    
    %Gr�fico de control
    
graficodecontrol=[GMaxi;Vcrit];

XxX=(1:t);

yminimo=min(min(graficodecontrol));
ymaximo=max(max(graficodecontrol)); 
plot(XxX, GMaxi, XxX, Vcrit)
title('GR�FICA DE CONTROL DEL AN�LISIS DE PUNTO DE CAMBIO.')
axis([(2*(m+1)) t yminimo ymaximo])
xlabel('MUESTRAS' )
ylabel('Gmax,n' )
grid on
legend('Gmax,n','L�mite de Control h');
datacursormode on 
       
end

else
    
%En el caso que no se encuentre disponible la dimensi�n del vector.
   
disp(' ');
disp('ERROR: el grafico de control no puede ser construido, debido a que no')
disp('se encuentra disponible la dimensi�n de su vector de observaci�n.')
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
disp('ERROR: LOS DATOS NO SON VECTORES DE OBSERVACI�N, ES DECIR, NO EST� MONITOREANDO UN VECTOR')
disp('DE CARACTER�STICAS DE CALIDAD.')
disp(' ');

else

%Datos At�picos (Outliers)

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuaci�n se realizar� la Prueba de Schwager y Margolin para la detecci�n de outliers,')
disp('con el fin de depurar los datos para el An�lisis de Fase I.')
disp(' ');
AUT=input('�Desea aplicar esta prueba?: No(0), Si(Cualquier otro n�mero) ');
disp(' ');

    %Realizo la prueba de outliers
    
if AUT~=0
    
    alp=input('Indique el nivel de significancia alfa: ');
    
    condi=margoline(matr,alp);
    
    if condi==3
        
        disp(' ');
        disp('La matriz de covarianzas muestral de los datos es singular.')
        disp('SI SELECCIONA SI, EL PROGRAMA DETENDR� SU EJECUCI�N.')
        sing=input('�Desea probar con otra data?: No(0), Si(Cualquier otro n�mero) ');
        
        if sing~=0
            
            return
            
        end
        
    elseif condi==1
        
        disp(' ');
        disp('Para la eliminaci�n de valores at�picos (outliers), elimine las observaciones con')
        disp('distancias estandarizadas grandes.')
        disp(' ');
        disp('Ingrese el nombre del archivo Excel, que contiene los datos depurados de valores at�picos')
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
disp('A continuaci�n se realizar� la Prueba de normalidad multivariante de Mardia, con el objeto de')
disp('validar el supuesto de normalidad multivariante.')
disp(' ');
AUT1=input('�Desea aplicar esta prueba?: No(0), Si(Cualquier otro n�mero) ');
disp(' ');

if AUT1~=0
    
    alp1=input('Indique el nivel de significancia alfa: ');
      
    condi1=mardia( matr,alp1 );
    
     if condi1==3
        
        disp(' ');
        disp('La matriz de covarianzas muestral de los datos es singular.')
        disp('SI SELECCIONA SI, EL PROGRAMA DETENDR� SU EJECUCI�N.')
        sing1=input('�Desea probar con otra data?: No(0), Si(Cualquier otro n�mero) ');
        
        if sing1~=0
            
            return
            
        end
        
     elseif condi1==0
         
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
        nnor=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro n�mero) ');
        
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
disp('A continuaci�n se realizar� la Prueba de ra�z unitaria de Fountis-Dickey, la cual examina')
disp('la existencia de una ra�z unitaria en una serie de tiempo multivariante autorregresiva.')
disp(' ');
AUT2=input('�Desea aplicar esta prueba?: No(0), Si(Cualquier otro n�mero) ');
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
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
        sing2=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro n�mero) ');
        
        if sing2==0
            
            return
            
        end
    
    elseif condi2==4
        
        disp(' ');
        disp('La prueba de Fountis-Dickey ha fallado, debido a que el orden del modelo autorregresivo')
        disp('vectorial VAR(p), no ha podido ser estimado.');
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
        noord=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro n�mero) ');
        
        if noord==0
            
            return
            
        end
        
    elseif condi2==2
        
        disp(' ');
        disp('La prueba de Fountis-Dickey ha fallado, debido a que ha ingresado un alfa fuera de los')
        disp('permitidos.');
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
        noalfa=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro n�mero) ');
        
        if noalfa==0
            
            return
            
        end
        
    elseif condi2==0
        
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
        noesta=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro n�mero) ');
        
        if noesta==0
            
            return
            
        end
        
    elseif condi2==5
        
        disp(' ');
        disp('La prueba de Fountis-Dickey ha fallado, debido a que la serie de tiempo')
        disp('multivariante es explosiva.');
        disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
        explosiva=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro n�mero) ');
        
        if explosiva==0
            
            return
            
        end
       
    elseif condi2==1
        
        disp('*PRESIONE CUALQUIER TECLA PARA CONTINUAR.') %Pausa
        pause 
        
    end
    
end

%Evaluaci�n de la Independencia.

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuaci�n se probar� la independencia de los datos.')
disp('Este an�lisis es divido en dos categor�as:')
disp(' ');
disp('*CATEGOR�A I: prueba la independencia en cada componente univariante de la serie de')
disp('tiempo multivariante.');
disp(' ');
disp('*CATEGOR�A II: prueba la existencia de una dependencia lineal din�mica en los datos de')
disp('la serie de tiempo multivariante.')
disp(' ');
disp('CATEGOR�A I: Prueba de Ljung-Box');
disp(' ');
AUT3=input('�Desea aplicar esta prueba?: No(0), Si(Cualquier otro n�mero) ');
disp(' ');

if AUT3~=0
    
    alp3=input('Indique el nivel de significancia alfa: ');
      
    condi3=LBprueba(matr,alp3);

    [tam,tam1]=size(condi3); %Tama�o del vector
    
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
disp('CATEGOR�A II: Versi�n multivariante de Chitturi y Hosking de la prueba de Portmanteau.');
disp('En esta categor�a se prueba la existencia de una dependencia lineal din�mica en los datos de')
disp('la serie de tiempo multivariante.')
disp(' ');
AUT4=input('�Desea aplicar esta prueba?: No(0), Si(Cualquier otro n�mero) ');
disp(' ');

if AUT4~=0
           
    alp4=input('Indique el nivel de significancia alfa: ');
    
    condi4=portmprueba(matr,alp4);
    
    if condi4==2
       
        disp(' ');
        disp('La matriz de covarianzas muestral de los datos es singular.')
        disp('SI SELECCIONA SI, EL PROGRAMA DETENDR� SU EJECUCI�N.')
        sing3=input('�Desea probar con otra data?: No(0), Si(Cualquier otro n�mero) ');
        
        if sing3~=0
            
            return
            
        end
        
    end
    
end

    %Decisi�n de la prueba de Independencia

if AUT3~=0 && AUT4~=0
        
if bandn==true && condi4==1
    
    disp(' ');
    disp('Los datos son independientes solo en la categor�a II.')
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
    ind=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro n�mero) ');
        
        if ind==0
            
            return
            
        end
    
elseif bandn==false && condi4==0
    
    disp(' ');
    disp('Los datos son independientes solo en la categor�a I.')
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
    ind1=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro n�mero) ');
        
        if ind1==0
            
            return
            
        end
        
elseif bandn==true && condi4==0
    
    disp(' ');
    disp('Los datos no son independientes en ambas categor�as.')
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
    ind2=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro n�mero) ');
        
        if ind2==0
            
            return
            
        end
        
elseif bandn==false && condi4==1
    
    disp('*PRESIONE CUALQUIER TECLA PARA CONTINUAR.') %Pausa
    pause  
        
end

elseif AUT3==0 && AUT4~=0
    
    disp('No se puede tomar una decisi�n con respecto a la independencia, debido a que no se ejecutaron')
    disp('las pruebas de independencia para ambas categor�as.')
    disp(' ');
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
    ind3=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro numero) ');
        
        if ind3==0
            
            return
            
        end

elseif AUT3~=0 && AUT4==0
    
    disp('No se puede tomar una decisi�n con respecto a la independencia, debido a que no se ejecutaron')
    disp('las pruebas de independencia para ambas categor�as.')
    disp(' ');
    disp('SI SELECCIONA NO, EL PROGRAMA DETENDR� SU EJECUCI�N.')
    ind4=input('�Desea continuar con el an�lisis?: No(0), Si(Cualquier otro numero) ');
        
        if ind4==0
            
            return
            
        end

end

fprintf('-------------------------------------------------------------------------------------------\n');
disp('Ha finalizado el an�lisis de Fase I.')
disp(' ');
disp('A CONTINUACI�N INICIARA EL AN�LISIS DE FASE II.')
disp(' ');
disp('La herramienta estad�stica utilizada para el an�lisis es un gr�fico de control basado en el');
disp('An�lisis de Punto de Cambio (CPA).')
disp(' ');
disp('*PRESIONE CUALQUIER TECLA PARA CONTINUAR.') %Pausa
pause  
        
%Lectura de datos Fase II.

[t,m,datos]=lecturafaseII;

matr1=datos;

%Verificando que los datos no provengan de procesos univariantes.

if m==1
    
disp(' ');
disp('ERROR: LOS DATOS NO SON VECTORES DE OBSERVACI�N, ES DECIR, NO EST� MONITOREANDO UN VECTOR')
disp('DE CARACTER�STICAS DE CALIDAD.')
disp(' ');

else
    
%Verificando que el p este en el rango

if m==2 || m==3 || m==4 || m==5 || m==10 || m==15 || m==20 || m==25
    
%Verificando que el tama�o de muestra sea mayor o igual a 2(p+1).
    
if t<(2*(m+1))
          
disp(' ');
disp('ERROR: EL TAMA�O DE MUESTRA ES MENOR AL M�NIMO REQUERIDO.')
disp(' ');

else  
    
%Construcci�n del grafico de control.

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuaci�n se proceder� a construir el Gr�fico de Control del CPA.')
disp(' ');
disp('Deber� indicar el nivel significancia alfa (probabilidad especificada de emitir una falsa')
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
            disp('Vector de medias, matriz de covarianzas y matriz de correlaciones muestral despu�s del cambio:')
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
            disp('Existe suficiente evidencia estad�stica para afirmar, que ha ocurrido un cambio en el')
            disp(['vector de medias, matriz de covarianzas o en ambos, en n igual a: ', num2str(j)]) 
            disp(' ');
            disp(['El punto estimado en donde ocurre el cambio es en la observaci�n: ', num2str(pcam)]) 
            disp(' ');
            disp('Conclusi�n: el proceso est� fuera de control, es decir, el proceso est� operando en presencia')
            disp('de causas asignables de variaci�n.')
            disp(' ');
            disp('Arriba se presentan los vectores de medias, matrices de covarianzas y matrices de correlaciones')
            disp('muestral, antes y despu�s del cambio.')
            
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
        disp('No existe suficiente evidencia estad�stica para afirmar, que ha ocurrido un cambio en el')
        disp('vector de medias, matriz de covarianzas o en ambos.')
        disp(' ');
        disp('Conclusi�n: el proceso est� bajo control estad�stico, es decir, el proceso opera �nicamente')
        disp('en presencia de causas fortuitas de variaci�n.')
        disp(' ');
        disp('Arriba se presentan las estimaciones del vector de medias, matriz de covarianzas y matriz de')
        disp('correlaciones.')
        
    end
    
    %Gr�fico de control
    
graficodecontrol=[GMaxi;Vcrit];

XxX=(1:t);

yminimo=min(min(graficodecontrol));
ymaximo=max(max(graficodecontrol));
plot(XxX, GMaxi, XxX, Vcrit)
title('GR�FICA DE CONTROL DEL AN�LISIS DE PUNTO DE CAMBIO.')
axis([(2*(m+1)) t yminimo ymaximo])
xlabel('MUESTRAS' )
ylabel('Gmax,n' )
grid on
legend('Gmax,n','L�mite de Control h');
datacursormode on
    
end

else
    
%En el caso que no se encuentre disponible la dimensi�n del vector.
    
disp(' ');
disp('ERROR: el grafico de control no puede ser construido, debido a que no')
disp('se encuentra disponible la dimensi�n de su vector de observaci�n.')
disp(' ');
    
end

end

end

end


end

