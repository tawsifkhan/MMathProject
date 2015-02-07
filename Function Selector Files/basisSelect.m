function basis = basisSelect(method,matchN)
switch lower(method)
    case {'sine'}
        basis=getBasisSine;
    case {'linear'}
        basis=getBasisLinear;
    case {'poly'}
        basis=getBasisPoly;
    case {'sinetrue'}
        basis=getBasisSineTrue(matchN);

end
end