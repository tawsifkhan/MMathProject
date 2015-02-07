function [func,xg] = reconstructorSelect(coEffs,basis,method,matchN)

switch lower(method)
    
    case {'sinetrue'}
        specs=getSpecs;
        [func,xg] = reconstructSineTrue(coEffs,basis,matchN);
    
    case {'sine'}
        [func,xg] = reconstructSine(coEffs,basis);
    
    case {'linear'}
        [func,xg] = reconstructLinear(coEffs,basis);
    
    case {'poly'}
        [func,xg] = reconstructPoly(coEffs,basis);
end

end