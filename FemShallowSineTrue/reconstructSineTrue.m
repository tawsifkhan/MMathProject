function [fg,xg]=reconstructSineTrue(coEffs,basis,matchN)
specs=getSpecs;

xg=getGaussianPoints(linspace(0,specs.J,matchN+1),matchN);
fg=zeros(6*matchN,1);
for mm=1:specs.nTrue
    size(coEffs)
    size(basis.ps(:,mm))
    size(fg(:,1))
    fg(:,1)=fg(:,1)+coEffs(mm)*basis.ps(:,mm);
end

end