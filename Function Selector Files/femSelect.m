function coEffMatrix = femSelect(method)
    switch lower(method)
        case {'sine'}
            coEffMatrix = femShallowSine;
        case {'linear'}
            coEffMatrix = femShallowLinear;
        case {'poly'}
            coEffMatrix = femShallowPoly;
    end
end