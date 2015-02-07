% FINITE ELEMENT CODE USING LINEAR BASIS

% Equation : u_tt=c^2*u_xx + beta*u_xxtt,  c^2=g*H, beta=H^2/6
% Returns  : coefficients at all times

function [c_matrix]=femShallowLinear

specs = getSpecs;                   % Physical Parameters of the problem
basis = getBasisLinear;             % Spatial Discretization of the problem
                                    % For example: basis.M = MASS matrix.

% Time Discretization: 2nd order Leapfrog timestepping
% [M+beta*K][csNext-2*csNow+csOld]=[dt^2*c^2*K*csNow]

mymatf=sparse(zeros(size(basis.M))); % (M+beta*K+(cd/2)*dt*M)   * csNext
mymatn=sparse(zeros(size(basis.M))); % (2*(M+beta*K)-c2*dt^2*K) * csNow
mymatp=sparse(zeros(size(basis.M))); % (-M-beta*K+(cd/2)*M*dt)  * csOld
b=2; %2 for dirichlet
mymatf(b:end,b:end)=(basis.M(b:end,b:end)+specs.beta*basis.K(b:end,b:end)+...
                    (specs.cd/2)*specs.dt*basis.M(b:end,b:end));  
mymatn(b:end,b:end)=(2*(basis.M(b:end,b:end)+specs.beta*basis.K(b:end,b:end))-...
                    specs.dt2*specs.c2*basis.K(b:end,b:end)); 
mymatp(b:end,b:end)=(-basis.M(b:end,b:end)-specs.beta*basis.K(b:end,b:end)+...
                    (specs.cd/2)*basis.M(b:end,b:end)*specs.dt); 
mymatf(1,1)=1; 
mymatf(end,end)=1;

xg = getGaussianPoints(linspace(0,specs.J,specs.linearN+1),specs.linearN);
v0AtGaussianPoints = specs.v0(xg');
csNow=getCoEffsLinear(v0AtGaussianPoints,basis);
csOld=csNow;
if b==2, csNow(specs.linearN+1)=0; csOld(specs.linearN+1)=0; end

c_matrix=zeros(specs.linearN+1,specs.numouts+1);    % Matrix to store all 
                                                    % coefficients
c_matrix(:,1)=csNow;

% Solve for cs^(n+1)
for ii=1:specs.numouts
    for jj=1:specs.numsteps;                        % specs.Numsteps=1
        specs.t=specs.t+specs.dt;
        rhside=mymatn*csNow+mymatp*csOld;
        csNext=mymatf\rhside;
        csOld=csNow; csNow=csNext;
    end
    c_matrix(:,ii+1)=csNow;
  
    if specs.toPlot==1
        [vg,xg]=reconstructLinear(csNow,basis);     % Reconstruction
        figure(1)
        clf
        set(gcf,'DefaultLineLineWidth',3,'DefaultTextFontSize',12,...
            'DefaultTextFontWeight','bold','DefaultAxesFontSize',12,...
            'DefaultAxesFontWeight','bold');
        plot(xg,vg,'b')
        xlabel('x')
        ylabel('displacement')
        title(['t = ' num2str(specs.t,2)])
        grid on
        axis([0 specs.J -2 2])
        drawnow
    end
end








