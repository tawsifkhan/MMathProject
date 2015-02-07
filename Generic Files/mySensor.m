function [C1,C2]=mySensor(method)
global index
specs=getSpecs;

% Sensor Properties
elementToPlace =round(specs.polyN/2);
elementsToSpan = round(index/2);
strength = 1;

plotFlag=1;

switch lower(method)
    case {'sinetrue'}
        xg = getGaussianPoints(linspace(0,specs.J,specs.polyN+1),specs.polyN);
        xLeft = xg((elementToPlace-1)*6+1);
        xRight = xLeft + xg(elementsToSpan*6);
        xg = getGaussianPoints(linspace(0,specs.J,specs.sineTrueN+1),specs.sineTrueN);
        for i = 1:size(xg,2)
            if xg(i)>=xLeft && xg(i)<=xRight
                actualSensor(i) = strength;
            else
                actualSensor(i) = 0;
            end
        end
        basis=getBasisSineTrue(specs.sineTrueN);
        coEffs=getCoEffsSineTrue(actualSensor',basis);
        DoF = specs.nTrue;
        
    case {'sine'}
        xg = getGaussianPoints(linspace(0,specs.J,specs.polyN+1),specs.polyN);
        toSkip = 6*4;
        xLeft = xg((elementToPlace-1)*6+1);
        xRight = xLeft + xg((elementsToSpan)*6);
        xg = getGaussianPoints(linspace(0,specs.J,specs.sineN+1),specs.sineN);
        for i = 1:size(xg,2)
            if xg(i)>=xLeft && xg(i)<=xRight
                actualSensor(i) = strength;
            else
                actualSensor(i) = 0;
            end
        end
        xg = getGaussianPoints(linspace(0,specs.J,specs.sineN+1),specs.sineN);
        basis=getBasisSine;
        coEffs=getCoEffsSine(actualSensor',basis);
        DoF = specs.n;
    case {'linear'}
        xg = getGaussianPoints(linspace(0,specs.J,specs.linearN+1),specs.linearN);
        toSkip = 6*1;
        actualSensor = zeros(size(xg));
        left = (elementToPlace - 1)*5*6 + 1;
        right = left + elementsToSpan*5*6 - 1;
        actualSensor(left:right) = strength;
        basis=getBasisLinear;
        coEffs=getCoEffsLinear(actualSensor',basis);
        DoF = specs.linearN+1;
    case {'poly'}
        xg = getGaussianPoints(linspace(0,specs.J,specs.polyN+1),specs.polyN);
        toSkip = 1;
        actualSensor = zeros(size(xg));
        left = (elementToPlace - 1)*6 + 1;
        right = left + elementsToSpan*6 - 1;
        actualSensor(left:right) = strength;
        basis=getBasisPoly;
        coEffs=getCoEffsPoly(actualSensor',basis);
        DoF = 5*specs.polyN + 1;
        
end
if plotFlag==1
    [constructedSensor,xSensor]=reconstructorSelect(coEffs,basis,method);
     set(gcf,'DefaultLineLineWidth',3,'DefaultTextFontSize',12,...
            'DefaultTextFontWeight','bold','DefaultAxesFontSize',12,...
            'DefaultAxesFontWeight','bold','color','w');
    plot(xSensor,constructedSensor,'r',xg,actualSensor,'b')
    axis([0 specs.J -0.5 1.5])
    grid on
    xTick = (xg(1:6:end));
    xLabel =repmat({''}, 1, size(xTick,2));
    for i = 1:toSkip:size(xTick,2)
        xLabel(1,i)={sprintf('%1.2f',xTick(1,i))};
    end
    set(gca,'XTick',[xTick xg(end)],'XTickLabel',[xLabel {sprintf('%1.2f',xg(end))}])
    error = norm(actualSensor' - constructedSensor)/(norm(actualSensor)*DoF);
    title(sprintf('%s basis\n Error %.2e',(method),error))
end

% Assemble C matrix
sizeCoEffs=size(coEffs,1);
C1=coEffs'*basis.K;
C2= zeros(1,sizeCoEffs);

end

