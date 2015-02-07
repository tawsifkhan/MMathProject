function [C1, C2]=mySensor2(method,l)
% This functions creates the model of the sensor using the method and the x
% for the peak.
% Returns a coloumn vector C of size 1 x n
specs=getSpecs;

actualSensor = @(x) sech(15*(x-l)); %l is location(peak) of the sensor.
plotFlag=0;                         %Set it to 1 to see the plot

switch lower(method)
    case {'sinetrue'}
        xg = getGaussianPoints(linspace(0,specs.J,specs.sineTrueN+1),specs.sineTrueN);
        basis=getBasisSineTrue(specs.sineTrueN);
        coEffs=getCoEffsSineTrue(actualSensor(xg'),basis);
        
    case {'sine'}
        frpintf('Projecting Sensor on Sine Basis')
        xg = getGaussianPoints(linspace(0,specs.J,specs.sineN+1),specs.sineN);
        basis=getBasisSine;
        coEffs=getCoEffsSine(actualSensor(xg'),basis);
        
    case {'linear'}
        fprintf('Projecting Sensor on Linear Basis')
        xg = getGaussianPoints(linspace(0,specs.J,specs.linearN+1),specs.linearN);
        basis=getBasisLinear;
        coEffs=getCoEffsLinear(actualSensor(xg'),basis);
    case {'poly'}
        
        fprintf('Projecting Sensor on Poly Basis')
        xg = getGaussianPoints(linspace(0,specs.J,specs.polyN+1),specs.polyN);
        basis=getBasisPoly;
        coEffs=getCoEffsPoly(actualSensor(xg'),basis);
        DoF = 5*specs.polyN + 1;
        
end

if plotFlag==1
    figure(1)
    clf
    [constructedSensor,xSensor]=reconstructorSelect(coEffs,basis,method);
    set(gcf,'DefaultLineLineWidth',2,'DefaultTextFontSize',12,...
        'DefaultTextFontWeight','normal','DefaultAxesFontSize',12,...
        'DefaultAxesFontWeight','normal','color','w');
    plot(xSensor,actualSensor(xSensor'),'k')
    hold on
    plot(xSensor,constructedSensor,'r')
    xlabel('x')
    ylabel('f(x)')
    axis([0 specs.J -0.5 1.5])
    title('Model Sensor')
    grid on
end

% Assemble C matrix
sizeCoEffs=size(coEffs,1);
C1=coEffs'*basis.M;
C2=zeros(1,sizeCoEffs);
end

