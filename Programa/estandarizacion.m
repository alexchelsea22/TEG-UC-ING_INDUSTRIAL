function [ output ] = estandarizacion( A )

[x,y]=size(A);

c1=cov(A);

[c2,c3]=eig(c1);

c4=diag(diag(c3.^((-1)/2)));

c5=mean(A);

c6=[];

for i=1:y

    c6=[c6,(ones(x,1)*c5(1,i))];
    
end

c7=(A-c6);

output=(c7*c2*c4*c2');

end

