function [ n,p,dat ] = lecturafaseII

disp(' ');
disp('A continuaci�n debe leer el archivo Excel que contiene los datos a estudiar, para leerlos')
disp('debe ingresar el nombre cuando se le indique.') 
disp(' ');
disp('SUGERENCIA: si su vector de caracter�sticas de calidad posee "p" caracter�sticas (variables),')
disp('introduzca muestras de tama�o mayores o iguales a 2(p+1).')
filename=input('Ingrese el nombre del archivo: ','s');
dat=xlsread(filename);
[n,p]=size(dat);

end

