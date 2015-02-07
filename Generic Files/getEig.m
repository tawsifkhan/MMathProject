% This is a script that can be used to check the eigenvalues. 
method = 'sine';
global index
for j=1:10
    index=j;
    basis = basisSelect(method);
    specs = getSpecs;
    I=eye(size(basis.M));
    O=zeros(size(basis.M));

    A1=[I O; O basis.M+specs.beta*basis.K];
    A2=[O I; -specs.c2*basis.K -specs.cd*basis.M];
    A=(A1)\A2;
    %A=full(A);
    E=eig(full(A1),full(A2));

    realES(j)=max(real(E));
end

method = 'linear';

for j=1:10
   index=j;
    basis = basisSelect(method);
    specs = getSpecs;
    I=eye(size(basis.M));
    O=zeros(size(basis.M));

    A1=[I O; O basis.M+specs.beta*basis.K];
    A2=[O I; -specs.c2*basis.K -specs.cd*basis.M];
    E=eig(full(A1),full(A2));

    realEL(j)=max(real(E))
end

method = 'poly';

for j=1:10
    index=j;
    basis = basisSelect(method);
    specs = getSpecs;
    I=eye(size(basis.M));
    O=zeros(size(basis.M));

    A1=[I O; O basis.M+specs.beta*basis.K];
    A2=[O I; -specs.c2*basis.K -specs.cd*basis.M];
    E=eig(full(A1),full(A2));

    realEP(j)=max(real(E))
end

figure(8)
%subplot(1,1,3)
plot(1:10,realES,'b')
hold on
plot(1:10,realEL,'r')
plot(1:10,realEP,'g')