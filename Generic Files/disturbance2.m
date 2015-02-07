
function [G1, G2]=disturbance2(method)

% Function to create tanhyperbolic shaped disturbance.
% This is created by superposition of two tanh functions.

% IMPORTANT: The disturbance matrix is a dual concept of sensor. So this
% file contains the term sensor in most parts but is actually the disturbance.

% Returns two coloumn vectors G1,G2 of size 1 x n.
specs=getSpecs;
ws1 = .1;     % Width 1
ws2 = .8;     % Width 2. Run this function with plotFlag = 1 to understand better.
l   = 3.5;    % Location

actualSensor1 = @(x) (tanh((1/ws1)*(x-(l-ws2)))-tanh((1/ws1)*(x-(l+ws2))))/2; %2.5 means the sensor at the center

ws1 = .1;
ws2 = .5;
l = 1;

actualSensor2 = @(x) (tanh((1/ws1)*(x-(l-ws2)))-tanh((1/ws1)*(x-(l+ws2))))/2;
actualSensor = @(x) actualSensor1(x) + actualSensor2(x);
plotFlag=1;

switch lower(method)
    case {'sinetrue'}
        xg = getGaussianPoints(linspace(0,specs.J,specs.sineTrueN+1),specs.sineTrueN);
        basis=getBasisSineTrue(specs.sineTrueN);
        coEffs=getCoEffsSineTrue(actualSensor(xg'),basis);
        DoF = specs.nTrue;
        
    case {'sine'}
        fprintf('Projecting Sensor on Sine Basis')
        xg = getGaussianPoints(linspace(0,specs.J,specs.sineN+1),specs.sineN);
        basis=getBasisSine;
        coEffs=getCoEffsSine(actualSensor(xg'),basis);
        DoF = specs.n;
    case {'linear'}
        fprintf(Projecting Sensor on Linear Basis')
        xg = getGaussianPoints(linspace(0,specs.J,specs.linearN+1),specs.linearN);
        
        basis=getBasisLinear;
        coEffs=getCoEffsLinear(actualSensor(xg'),basis);
        DoF = specs.linearN+1;
    case {'poly'}
        fprintf('Projecting Sensor on Poly Basis')
        xg = getGaussianPoints(linspace(0,specs.J,specs.polyN+1),specs.polyN);
        basis=getBasisPoly;
        coEffs=getCoEffsPoly(actualSensor(xg'),basis);
        DoF = 5*specs.polyN + 1;
        
end

if plotFlag==1
    figure(1)
    
    [constructedSensor,xSensor]=reconstructorSelect(coEffs,basis,method);
    set(gcf,'DefaultLineLineWidth',3,'DefaultTextFontSize',12,...
        'DefaultTextFontWeight','bold','DefaultAxesFontSize',12,...
        'DefaultAxesFontWeight','bold','color','w');
    plot(xSensor,actualSensor(xSensor'),'k')
    hold on
    plot(xSensor,constructedSensor,'r')
    xlabel('x')
    ylabel('f(x)')
    
    axis([0 specs.J -0.5 1.5])
    title('Model Disturbance')
    grid on
end

% Assemble G matrix
sizeCoEffs=size(coEffs,1);
G1=coEffs'*basis.M;
G2=zeros(1,sizeCoEffs);
end

