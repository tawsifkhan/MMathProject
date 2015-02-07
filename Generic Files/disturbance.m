function [G1, G2]=disturbance(method)
% Function to create tanhyperbolic shaped disturbance.
% This is created by superposition of two tanh functions.

% IMPORTANT: The disturbance matrix is a dual concept of sensor. So this
% file contains the term sensor in most parts but is actually the disturbance.

%global d;
specs=getSpecs;

actualSensor = @(x) sech(15*(x-1.5));

plotFlag=1;

switch lower(method)
    case {'sinetrue'}
        xg = getGaussianPoints(linspace(0,specs.J,specs.sineTrueN+1),specs.sineTrueN);
        basis=getBasisSineTrue(specs.sineTrueN);
        coEffs=getCoEffsSineTrue(actualSensor(xg'),basis);
        DoF = specs.nTrue;
    case {'sine'}
        fprintf('Projecting Disturbance on Sine Basis')
        xg = getGaussianPoints(linspace(0,specs.J,specs.sineN+1),specs.sineN);
        basis=getBasisSine;
        coEffs=getCoEffsSine(actualSensor(xg'),basis);
        DoF = specs.n;
    case {'linear'}
        fprintf('Projecting Disturbance on Linear Basis')
        xg = getGaussianPoints(linspace(0,specs.J,specs.linearN+1),specs.linearN);
        basis=getBasisLinear;
        coEffs=getCoEffsLinear(actualSensor(xg'),basis);
        DoF = specs.linearN+1;
    case {'poly'}
        fprintf('Projecting Disturbance on Poly Basis')
        xg = getGaussianPoints(linspace(0,specs.J,specs.polyN+1),specs.polyN);
        basis=getBasisPoly;
        coEffs=getCoEffsPoly(actualSensor(xg'),basis);
        DoF = 5*specs.polyN + 1;
        
end

if plotFlag==1
    figure(1)
    subplot(2,1,1)
    
    [constructedSensor,xSensor]=reconstructorSelect(coEffs,basis,method);
    set(gcf,'DefaultLineLineWidth',3,'DefaultTextFontSize',12,...
        'DefaultTextFontWeight','bold','DefaultAxesFontSize',12,...
        'DefaultAxesFontWeight','bold','color','w');
    plot(xSensor,actualSensor(xSensor'),'k')
    hold on
    
    xlabel('x')
    ylabel('f(x)')
    axis([0 specs.J -0.5 1.5])
    
    error = norm(actualSensor(xg') - constructedSensor)/(norm(actualSensor(xg'))*DoF);
    
end

% Assemble C matrix
sizeCoEffs=size(coEffs,1);
G1=coEffs'*basis.M;
G2=zeros(1,sizeCoEffs);
end

