function coEffs = getCoEffsPoly(func,basis)

% This functions returns the coefficients using the 6th order basis.
% 'func' must be evaluated over the gaussian points with the same spatial
% discretization as the basis.

locicmat=[basis.ps(:,1) basis.ps(:,3) basis.ps(:,4) basis.ps(:,5)...
          basis.ps(:,6) basis.ps(:,2)];
specs=getSpecs;
coEffs=zeros(5*specs.polyN+1,1);

for kk=1:specs.polyN,
    f_kk=func(1+(kk-1)*6:kk*6);
    coEffs_kk=locicmat\f_kk;
    coEffs(1+(kk-1)*5:kk*5)=coEffs_kk(1:5);
end
end