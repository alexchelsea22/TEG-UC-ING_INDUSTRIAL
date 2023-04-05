function [ rvgcorregido ] = estGkn( x,p,m,i )

%Programa para determinar el GLR corregido.

rvgcorregido=((doslogkn(x,m,i)*(p*(p+3)))/(gkn(p,m,i)));

end

