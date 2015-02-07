function [vg,xg]= reconstructPoly(coEffs,basis)
'Reoncstruction using Poly'
specs=getSpecs;

xg=getGaussianPoints(linspace(0,specs.J,specs.polyN+1),specs.polyN);
for kk=1:specs.polyN, gli(kk,:)=[1+(kk-1)*5, 1+(kk)*5, (kk-1)*5+2:(kk-1)*5+5]; end
vg=zeros(6*specs.polyN,1);
for kk=1:specs.polyN,
    for mm=1:6
        vg(1+(kk-1)*6:kk*6,1)=vg(1+(kk-1)*6:kk*6,1)+coEffs(gli(kk,mm))*basis.ps(:,mm);
    end
end

[~,bb]=sort(xg,'ascend');
xg=xg(bb);    
vg=vg(bb);

end