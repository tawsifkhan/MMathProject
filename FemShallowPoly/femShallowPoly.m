% FINITE ELEMENT CODE USING 6TH ORDER POLYNOMIAL BASIS

% Equation : u_tt=c^2*u_xx + beta*u_xxtt,  c^2=g*H, beta=H^2/6
% Returns  : coefficients at all times

function cMatrix=femShallowPoly
specs = getSpecs;
basis = getBasisPoly;

% Time Discretization
% 2nd order Leapfrog timestepping

% [M+beta*K][cs^(n+1)-2*cs^n+c^(n-1)]=[dt^2*c^2*K*cs]

% Solve for: cs^(n+1)

mymatf=sparse(zeros(size(basis.M)));
mymatn=sparse(zeros(size(basis.M)));
mymatp=sparse(zeros(size(basis.M)));
b=2; %2 for dirichlet
mymatf(b:end,b:end)=(basis.M(b:end,b:end)+specs.beta*basis.K(b:end,b:end)+(specs.cd/2)*specs.dt*basis.M(b:end,b:end));  % (M+beta*K+(cd/2)*dt*M)   * a^(n+1)
mymatn(b:end,b:end)=(2*(basis.M(b:end,b:end)+specs.beta*basis.K(b:end,b:end))-specs.dt2*specs.c2*basis.K(b:end,b:end)); % (2*(M+beta*K)-c2*dt^2*K) * a^n
mymatp(b:end,b:end)=(-basis.M(b:end,b:end)-specs.beta*basis.K(b:end,b:end)+(specs.cd/2)*basis.M(b:end,b:end)*specs.dt); % -M-beta*K+(cd/2)*M*dt    * a^(n-1)
mymatf(1,1)=1; mymatf(end,end)=1;

% Compute cs^n and cs^(n-1) using v0 and v0_t
xg = getGaussianPoints(linspace(0,specs.J,specs.polyN+1),specs.polyN);
v0AtGaussianPoints = specs.v0(xg');

csNow=getCoEffsPoly(v0AtGaussianPoints,basis);
csNow(specs.polyN*5+1)=0;
cs_old=csNow;

% Store all the coefficients over time in two matrices
cMatrix=zeros(specs.polyN*5+1,specs.numouts+1);
cMatrix(:,1)=csNow;

% Solve for cs^(n+1)

for ii=1:specs.numouts
    for jj=1:specs.numsteps;
        specs.t=specs.t+specs.dt;
        rhside=mymatn*csNow+mymatp*cs_old;
        cs_next=mymatf\rhside;
        cs_old=csNow; csNow=cs_next;
    end
    cMatrix(:,ii+1)=csNow;
    
    % Reconstruction using the basis
    if specs.toPlot==1
        [vg,xg]=reconstructPoly(csNow,basis);   
        figure(2)
        clf
        set(gcf,'DefaultLineLineWidth',3,'DefaultTextFontSize',12,...
            'DefaultTextFontWeight','bold','DefaultAxesFontSize',12,...
            'DefaultAxesFontWeight','bold');
        plot(xg,vg,'b-')
        xlabel('x')
        ylabel('displacement')
        title(['t = ' num2str(specs.t,2)])
        grid on
        axis([0 specs.J -2 2])
        drawnow
    end
    
end
end








