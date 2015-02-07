function basis = getBasisLinear
% Function defines the linear basis on a canonical element
% and returns the shape functions, mass and stiffness matrices.

specs=getSpecs;
x = linspace(0,specs.J,specs.linearN+1);
xi=[-0.932469514203152 -0.661209386466265 -0.238619186083197 ... 
     0.238619186083197 0.661209386466265 0.932469514203152];
wts=[0.17132449237910 0.360761573048139 0.467913934572691];
wts=[wts wts(3:-1:1)];

% Shape functions
nm1=0.5*(1-xi);
np1=0.5*(1+xi);

nm1p=-0.5;
np1p=0.5;

nm1pp=0;
np1pp=0;

% store the polynomials for a more elegant way of defining the k matrix

myps=zeros(6,2);
mypsp=zeros(6,2);
mypspp=zeros(6,2);

myps(:,1)=nm1;
myps(:,2)=np1;

mypsp(:,1)=nm1p;
mypsp(:,2)=np1p;

mypspp(:,1)=nm1pp;
mypspp(:,2)=np1pp;

K=(zeros((specs.linearN)+1));
M=(zeros((specs.linearN)+1));

for kk=1:specs.linearN
    xm=x(kk); xp=x(kk+1); dx=xp-xm; %xvals=xm+(xi+1)*0.5*dx;
    for ii=1:2
        for jj=1:2
            kl(ii,jj)=(2/dx)*sum(wts.*(mypsp(:,ii)').*(mypsp(:,jj))');
            ml(ii,jj)=(dx/2)*sum(wts.*(myps(:,ii)').*(myps(:,jj))');
        end
    end
    K(kk:kk+1,kk:kk+1)=K(kk:kk+1,kk:kk+1)+kl;
    M(kk:kk+1,kk:kk+1)=M(kk:kk+1,kk:kk+1)+ml;
end
K(1,:)   =[1 zeros(1,(specs.linearN))];   K(:,1)   =[1 zeros(1,(specs.linearN))]';
K(end,:) =[zeros(1,(specs.linearN)) 1];   K(:,end) =[zeros(1,(specs.linearN)) 1]';
M(1,:)   =[1 zeros(1,(specs.linearN))];   M(:,1)   =[1 zeros(1,(specs.linearN))]';
M(end,:) =[zeros(1,(specs.linearN)) 1];   M(:,end) =[zeros(1,(specs.linearN)) 1]';
K = sparse(K);
M = sparse(M);

basis = struct('elements',specs.linearN,...
               'ps',myps,...
               'psp',mypsp,...
               'pspp',mypspp,...
               'M',M,...
               'K',K);

end
