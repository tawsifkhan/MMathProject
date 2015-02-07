function [fg,xg]=reconstructSine(coEffs,basis)
'Reoncstruction using Sine'

specs=getSpecs;

xg=getGaussianPoints(linspace(0,specs.J,specs.sineN+1),specs.sineN);
fg=zeros(6*specs.sineN,1);
for mm=1:specs.n
    fg(:,1)=fg(:,1)+coEffs(mm)*basis.ps(:,mm);
end

end