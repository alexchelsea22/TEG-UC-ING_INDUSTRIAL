function [ rvg ] = doslogkn( x,m,i )

%Programa para determinar el estadístico de razón de log-verosimilitud
%doble negativa.

Son=Sij(x,m,0);

Sok=Sij(x,i,0);

Skn=Sij(x,m,i);

rvg=((m-1)*log10(det(Son)))-((i-1)*log10(det(Sok)))-((m-i-1)*log10(det(Skn)));

end

