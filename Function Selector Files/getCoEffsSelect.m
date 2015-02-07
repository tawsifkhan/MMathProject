function coEffs = getCoEffsSelect(func,basis,method)

switch lower(method)
    
    case {'sinetrue'}
        coEffs = getCoEffsSineTrue(func,basis);
    
    case {'sine'}
        coEffs = getCoEffsSine(func,basis);
    
    case {'linear'}
        coEffs = getCoEffsLinear(func,basis);
    
    case {'poly'}
        coEffs = getCoEffsPoly(func,basis);
end

end