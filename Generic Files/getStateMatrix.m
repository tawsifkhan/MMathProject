function [A1, A2]=getStateMatrix(method)

% This functions returns the state matrices of the system using the
% discretization method given as input

specs=getSpecs;
switch lower(method)
    case {'linear'},    basis=getBasisLinear;
    case {'poly'},      basis=getBasisPoly;
    case {'sine'},      basis=getBasisSine;
    case {'sinetrue'},  basis=getBasisSineTrue(specs.sineTrueN);
end

I=eye(size(basis.M));
O=zeros(size(basis.M));

A1=[I O; O basis.M+specs.beta*basis.K];
A2=[O I; -specs.c2*basis.K -specs.cd*basis.M];

A=(A1)\A2;              % This will most probably will remain unused.

end
