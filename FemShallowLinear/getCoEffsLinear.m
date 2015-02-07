function coEffs = getCoEffsLinear(func,basis)

% This functions returns the coefficients using the linear basis.
% 'func' must be evaluated over the gaussian points with the same spatial
% discretization as the basis.

locicmat=[basis.ps(:,1) basis.ps(:,2)];
specs=getSpecs;
coEffs=zeros(specs.linearN+1,1);
for kk=1:specs.linearN,
    f_kk=func(1+(kk-1)*6:kk*6);
    coEffs_kk=locicmat\f_kk;
    coEffs(kk)=coEffs_kk(1);
end
end