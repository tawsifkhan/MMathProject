function coEffs = getCoEffsSineTrue(func,basis)

specs=getSpecs;
coEffs=zeros(specs.nTrue,1);
for i=1:specs.nTrue
    coEffs(i)=basis.ps(:,i)\func;
end
end
