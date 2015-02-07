function [vg,xg]= reconstructLinear(coEffs,basis)
'Reoncstruction using Linear'
 specs = getSpecs;
% basis = getBasisLinear;

vg=zeros(6*specs.linearN,1);
xg=getGaussianPoints(linspace(0,specs.J,specs.linearN+1),specs.linearN);

%vg=interp1(specs.x,vlinear,xg)';

for kk=1:specs.linearN,
    vg(1+(kk-1)*6:kk*6,1)=vg(1+(kk-1)*6:kk*6,1)+coEffs(kk)*basis.ps(:,1);
    vg(1+(kk-1)*6:kk*6,1)=vg(1+(kk-1)*6:kk*6,1)+coEffs(kk+1)*basis.ps(:,2);
end
end