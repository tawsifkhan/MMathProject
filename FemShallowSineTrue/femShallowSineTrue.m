function [cMatrix]=femShallowSineTrue
% Equation   : v_tt=c^2*v_xx + beta*v_xxtt - c_d*v_t + f*u,
% Parameters : c^2=g*H, beta=H^2/6, x = [0,J], t=[0,T]
% Method     : Expansion over Sine Basis


specs=getSpecs;
basis = getBasisSineTrue(specs.sineTrueN);

% Time Discretization
% 2nd order Leapfrog timestepping
% [M+beta*K][cs^(n+1)-2*cs^n+c^(n-1)]=[dt^2*c^2*K*cs]
mymatf=(basis.M+specs.beta*basis.K+(specs.cd/2)*specs.dt*basis.M);   %(M+beta*K+(cd/2)*dt*M)   * a^(n+1)
mymatn=(2*(basis.M+specs.beta*basis.K)-specs.dt2*specs.c2*basis.K);  %(2*(M+beta*K)-c2*dt^2*K) * a^n
mymatp=(-basis.M-specs.beta*basis.K+(specs.cd/2)*basis.M*specs.dt);  %(-M-beta*K+(cd/2)*M*dt)  * a^(n-1)

% basisMatrix coloumns are the basis functions
% Number of rows     = # of x values used to compute basis
%                    = # of gauss. points every interval x # of intervals
% Number of coloumns = # of basis functions
%                    = # of modes

basisMatrix=zeros(6*specs.sineTrueN,specs.nTrue);
for i=1:specs.nTrue
    basisMatrix(:,i)=basis.ps(:,i);
end

% Compute cs^n (call it cs_now) using u0
xg=getGaussianPoints(linspace(0,specs.J,specs.sineTrueN+1),specs.sineTrueN);
cs_now = getCoEffsSineTrue(specs.v0(xg'),basis);
cs_old=cs_now;

% Store all the coefficients over time in a matrix
cMatrix=zeros(specs.nTrue,specs.numouts+1);
cMatrix(:,1)=cs_now;


% Solve for cs^(n+1) (call it cs_next)
for ii=1:specs.numouts
    for jj=1:specs.numsteps;
        specs.t=specs.t+specs.dt;
        rhside=mymatn*cs_now+mymatp*cs_old;
        cs_next=mymatf\rhside;
        cs_old=cs_now; cs_now=cs_next;
    end
    cMatrix(:,ii+1)=cs_now;
    if specs.toPlot==1
        % [vg,xg]=reconstructSine(cs_now,basis,specs.sineN);    % Reconstruction
        vg=zeros(6*specs.sineTrueN,1);
        for mm=1:specs.nTrue
            vg(:,1)=vg(:,1)+cs_now(mm)*basis.ps(:,mm);
        end
        
        
        figure(2)
        clf
        set(gcf,'DefaultLineLineWidth',3,'DefaultTextFontSize',12,...
            'DefaultTextFontWeight','bold','DefaultAxesFontSize',12,...
            'DefaultAxesFontWeight','bold');
        plot(xg,vg,'b-');
        xlabel('x')
        ylabel('displacement')
        title(['t = ' num2str(specs.t,2)])
        grid on
        axis([0 specs.J -2 2])
        drawnow
    end
end
%      figure(2)
%      clf
%      mycontour1(tt,specs.x,v_matrix), shading flat, axis tight
end








