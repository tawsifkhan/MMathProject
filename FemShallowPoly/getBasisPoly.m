function basis = getBasisPoly

% Function defines the polynomial basis on a canonical element
% and returns the shape functions, mass and stiffness matrices.

specs=getSpecs;
x=linspace(0,specs.J,specs.polyN+1);
xi=[-0.932469514203152 -0.661209386466265 -0.238619186083197 ... 
      0.238619186083197 0.661209386466265 0.932469514203152];
wts=[0.17132449237910 0.360761573048139 0.467913934572691];
wts=[wts wts(3:-1:1)];
m = length(xi);
% Legendre Polynomials
p0=ones(size(xi));
p1=xi;
p2=(1/(1+1))*((2*1+1)*xi.*p1-1*p0);
p3=(1/(2+1))*((2*2+1)*xi.*p2-2*p1);
p4=(1/(3+1))*((2*3+1)*xi.*p3-3*p2);
p5=(1/(4+1))*((2*4+1)*xi.*p4-4*p3);

% Derivatives using the recursive method    
p0p=0;
p1p=1;
p2p=(2*1+1)*p1+p0p;
p3p=(2*2+1)*p2+p1p;
p4p=(2*3+1)*p3+p2p;
p5p=(2*4+1)*p4+p3p;
    
p0pp=0;
p1pp=0;
p2pp=3;
p3pp=15*xi;
p4pp=0.5*105*xi.*xi-0.5*15;
p5pp=0.5*315*xi.*xi.*xi-0.5*105*xi;

% Shape functions
nm1=0.5*(1-xi);
np1=0.5*(1+xi);
n02=(p2-p0)/sqrt(2*(2*2-1));
n03=(p3-p1)/sqrt(2*(2*3-1));
n04=(p4-p2)/sqrt(2*(2*4-1));
n05=(p5-p3)/sqrt(2*(2*5-1));

nm1p=-0.5;
np1p=0.5;
n02p=(p2p-p0p)/sqrt(2*(2*2-1));
n03p=(p3p-p1p)/sqrt(2*(2*3-1));
n04p=(p4p-p2p)/sqrt(2*(2*4-1));
n05p=(p5p-p3p)/sqrt(2*(2*5-1));

nm1pp=0;
np1pp=0;
n02pp=(p2pp-p0pp)/sqrt(2*(2*2-1));
n03pp=(p3pp-p1pp)/sqrt(2*(2*3-1));
n04pp=(p4pp-p2pp)/sqrt(2*(2*4-1));
n05pp=(p5pp-p3pp)/sqrt(2*(2*5-1));

% store the polynomials for a more elegant way of defining the k matrix

myps=zeros(m,6);
mypsp=zeros(m,6);
mypspp=zeros(m,6);

myps(:,1)=nm1;
myps(:,2)=np1;
myps(:,3)=n02;
myps(:,4)=n03;
myps(:,5)=n04;
myps(:,6)=n05;

mypsp(:,1)=nm1p;
mypsp(:,2)=np1p;
mypsp(:,3)=n02p;
mypsp(:,4)=n03p;
mypsp(:,5)=n04p;
mypsp(:,6)=n05p;

mypspp(:,1)=nm1pp;
mypspp(:,2)=np1pp;
mypspp(:,3)=n02pp;
mypspp(:,4)=n03pp;
mypspp(:,5)=n04pp;
mypspp(:,6)=n05pp;


%   Assemble the local matrices
%   Set Global Order: nm1 n01 n02 n03 n04....np1
%   Map the local matrices to the global matrices

K=(zeros((specs.polyN)*5+1));
M=(zeros((specs.polyN)*5+1));

%   gli stores the indices for mapping local to global matrices
for kk=1:specs.polyN, gli(kk,:)=[1+(kk-1)*5, 1+(kk)*5, (kk-1)*5+2:(kk-1)*5+5]; end

for kk=1:specs.polyN
    xm=x(kk); xp=x(kk+1); dx=xp-xm; %xvals=xm+(xi+1)*0.5*dx;
    % Define the local matrices: kl,ml
    for ii=1:6,
        for jj=1:6,
        kl(ii,jj)=(2/dx)*sum(wts.*(mypsp(:,ii)').*(mypsp(:,jj))');
        ml(ii,jj)=(dx/2)*sum(wts.*(myps(:,ii)').*(myps(:,jj))');
        i_kk=gli(kk,ii);   j_kk=gli(kk,jj);
        K(i_kk,j_kk)=K(i_kk,j_kk)+kl(ii,jj);
        M(i_kk,j_kk)=M(i_kk,j_kk)+ml(ii,jj);
        end
    end
end
K(1,:)   =[1 zeros(1,(specs.polyN)*5)];   K(:,1)   =[1 zeros(1,(specs.polyN)*5)]';
K(end,:) =[zeros(1,(specs.polyN)*5) 1];   K(:,end) =[zeros(1,(specs.polyN)*5) 1]';
M(1,:)   =[1 zeros(1,(specs.polyN)*5)];   M(:,1)   =[1 zeros(1,(specs.polyN)*5)]';
M(end,:) =[zeros(1,(specs.polyN)*5) 1];   M(:,end) =[zeros(1,(specs.polyN)*5) 1]';
K = sparse(K);
M = sparse(M);

basis = struct('elements',specs.polyN,...  % Number of Elements
               'ps',myps,...               % Basis functions 
               'psp',mypsp,...             % Spatial Derivatives
               'pspp',mypspp,...           % 2nd Spatial Derivatives 
               'M',M,...                   % Mass Matrix 
               'K',K);                     % Stiffness Matrix 

end
