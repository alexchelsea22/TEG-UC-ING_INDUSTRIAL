function [ n,p,dat ] = lecturafaseII

disp(' ');
disp('A continuación debe leer el archivo Excel que contiene los datos a estudiar, para leerlos')
disp('debe ingresar el nombre cuando se le indique.') 
disp(' ');
disp('SUGERENCIA: si su vector de características de calidad posee "p" características (variables),')
disp('introduzca muestras de tamaño mayores o iguales a 2(p+1).')
filename=input('Ingrese el nombre del archivo: ','s');
dat=xlsread(filename);
[n,p]=size(dat);

end

