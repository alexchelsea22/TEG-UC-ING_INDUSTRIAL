function [ n,p,dat ] = lecturafaseI

%Lectura de Datos para la Fase I

fprintf('-------------------------------------------------------------------------------------------\n');
disp('A continuación debe leer el archivo Excel que contiene los datos para el análisis de')
disp('Fase I del proceso, para leerlos debe ingresar el nombre cuando se le indique.') 
disp(' ');
filename=input('Ingrese el nombre del archivo: ','s');
dat=xlsread(filename);
[n,p]=size(dat);

end

