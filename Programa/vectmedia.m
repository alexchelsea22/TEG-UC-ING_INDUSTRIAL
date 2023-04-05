function [ output ] = vectmedia( x,m,i )

%Programa para estimar el vector de medias.

Me=[];

for k=(i+1):m
    
    Me=[Me;x((k),:)];

end

output=mean(Me)';

end

