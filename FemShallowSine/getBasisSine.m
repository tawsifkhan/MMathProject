% Function defines the sine basis on the domain.
% NOTE: matchN allows the basis to match a given x-discretization by the
%       number of elements. Each element has 6 gaussian points like the 
%       polynomial and linear basis.
% RETURNS: the shape functions, mass and stiffness matrices.

function basis = getBasisSine

specs = getSpecs; 
xg=getGaussianPoints(linspace(0,specs.J,specs.sineN+1),specs.sineN);

L2_norm=1;%sqrt(specs.J/2);
for i=1:specs.n
    myps(:,i)=(1/L2_norm)*sin((1/specs.J)*i*pi*xg);
    mypsp(:,i)=(1/L2_norm)*(i*pi/specs.J)*cos((1/specs.J)*i*pi*xg);
    mypspp(:,i)=-(1/L2_norm)*(i*pi/specs.J)^2*sin((1/specs.J)*i*pi*xg);
    myps_coeff(i)=(1/L2_norm);
    mypsp_coeff(i)=(1/L2_norm)*((i*pi)/specs.J);
    if mod(i,2)==0
        mypsinteg(:,i)=0;
    else
        mypsinteg(:,i)=L2_norm*(2*specs.J)/(i*pi);
    end
end

K = zeros(specs.n);
M = zeros(specs.n);

% Create Mass and Stiffness matrices
for ii=1:specs.n,
    K(ii,ii)=mypsp_coeff(ii)^2*(specs.J/2);
    M(ii,ii)=myps_coeff(ii)^2*(specs.J/2);
end

K = sparse(K);
M = sparse(M);

basis = struct('Elements',specs.sineN,      ... % Number of Elements
               'ps',myps,                   ... % Basis functions
               'psp',mypsp,                 ... % Spatial Derivatives
               'pspp',mypspp,               ... % 2nd Spatial Derivatives
               'M',M,                       ... % Mass matrix
               'K',K,                       ... % Stiffness matrix
               'xg',xg     );                         
end


