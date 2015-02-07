% This file can be ignored completely.
% This is a script to test pieces of my codes.

noisefile
myKalman('sine','sineTrue')
%plotOSL
return
figure(2)
clf
clc
subplot(3,1,1)
mySensor2('sine');
subplot(3,1,2)
mySensor2('linear');
subplot(3,1,3)
mySensor2('poly');
return
clc
method = 'sine';
 [A1,A2] = getStateMatrix(method);
 A=A1\A2;
 full(A1)
 full(A2)
 full(A)
 [C1, C2] = mySensor2(method) ; 
 obvsMat = obsv(A2,[C1 C2]);
 rank(obvsMat)
 [~,d,~]=svd(obvsMat);
 diag(d)
 return
specs = getSpecs;
basisSine=getBasisSine;
basisLinear=getBasisLinear;
basisPoly=getBasisPoly;
size(basisSine.M)
size(basisLinear.M)
return


xg =getGaussianPoints(linspace(0,5,6),5);
actualSensor=zeros(size(xg))
a = 2;
b = 10+eps;
c = 10;
if b>=a && b<=c
    'B inside'
else
    'B Outside'
end
return
%================================
for i=1:size(tt,2)
    Z(:,i+1)= linsolve(full(trueA1),specs.dt*(trueA2*Z(:,i))+trueA1*Z(:,i));
end

for i=1:size(tt,2)
    Ze(:,i+1)= linsolve(full(A1),specs.dt*(A2-L*[C1 C2])*Ze(:,i)+specs.dt*y(:,i)*L+A1*Ze(:,i));
end

%---------------------------------
% clc
% global index
% for i = 5:5: 300
%     index = i;
% specs = getSpecs;
% basisSine=getBasisSine(specs.sineN);
% basisLinear=getBasisLinear;
% basisPoly=getBasisPoly;
% size(basisSine.M)
% size(basisLinear.M)
% size(basisPoly.M)
%end
% % originalStates = femShallowSine;
% % save('originalStates');
% tic
% femShallowPoly;
% toc
% tic
% femShallowLinear;
% toc
% tic
% femShallowSine;
% toc
%
% for i = 1:10
%     a(i)=5*5*i+1;
% end
% return
% specs = getSpecs;
% for kk=1:specs.polyN, gli(kk,:)=[1+(kk-1)*5, 1+(kk)*5, (kk-1)*5+2:(kk-1)*5+5]; end
% for k=0:specs.polyN-1
%     glii(k+1,1) = 1 + (k+1-1)*5;
%     glii(k+1,2) = 1+(k+1)*5;
%     for i=2:specs.polyN
%         glii(k+1,i+1) = (k)*5+i;
%     end
% end
% gli=gli-1;
% basis = getBasisPoly;
% mypsp = basis.psp;
% myps = basis.ps;
% x = linspace(0,specs.J, specs.polyN+1);
% kl=zeros(6,6);
% ml=zeros(6,6);
% wts=[0.17132449237910 0.360761573048139 0.467913934572691];
% wts=[wts wts(3:-1:1)];
% K = zeros(5*specs.polyN+1);
% M = zeros(5*specs.polyN+1);
% for k=0:specs.polyN-1
%     xm=x(k+1);
%     xp=x(k+2);
%     dx=xp-xm;
%     for i =0:5
%         for j = 0:5
%             klRow = 0;
%             mlRow = 0;
%             for m=0:5
%                     klRow = klRow+wts(m+1)*mypsp(m+1,i+1)*mypsp(m+1,j+1);
%                     mlRow = mlRow+wts(m+1)*myps(m+1,i+1)*myps(m+1,j+1);
%             end
%             kl(i+1,j+1) =(2/dx)*klRow;
%             ml(i+1,j+1) =(dx/2)*mlRow;
%             
%                 inow = gli(k+1,i+1);
%                 jnow = gli(k+1,j+1);
%                 know = kl(i+1,j+1);
%                 mnow = ml(i+1,j+1);
%                 
%                 K(inow+1,jnow+1) = K(inow+1,jnow+1)+know;
%                 M(inow+1,jnow+1)=M(inow+1,jnow+1)+ mnow;
%                 
%             
%         end
%     end
% end
% K(1,:)   =[1 zeros(1,(specs.polyN)*5)];   K(:,1)   =[1 zeros(1,(specs.polyN)*5)]';
% K(end,:) =[zeros(1,(specs.polyN)*5) 1];   K(:,end) =[zeros(1,(specs.polyN)*5) 1]';
% M(1,:)   =[1 zeros(1,(specs.polyN)*5)];   M(:,1)   =[1 zeros(1,(specs.polyN)*5)]';
% M(end,:) =[zeros(1,(specs.polyN)*5) 1];   M(:,end) =[zeros(1,(specs.polyN)*5) 1]';
% 
% max(basis.M - M)
% max(basis.K - K)
%                 
%                 
 