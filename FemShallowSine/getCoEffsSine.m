function coEffs = getCoEffsSine(func,basis)

specs=getSpecs;
coEffs=zeros(specs.n,1);
for i=1:specs.n
    coEffs(i)=basis.ps(:,i)\func;
end
end
