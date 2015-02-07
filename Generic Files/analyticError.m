% This is like a test function where the analytical solution is compared
% with the numerical solutions. 
clear all
global index;
indexElementsArray = 1:1:100;
specs = getSpecs;
n=2;
alpha = -((n*pi/specs.J)^2*specs.c2)/(1+specs.beta*(n*pi/specs.J)^2);
d1 = 0.5; d2 = 0.5;
a = @(t) d1*exp(sqrt(alpha)*t)+d2*exp(-sqrt(alpha)*t);
vExact=@(x,t) a(t)*sin(n*pi*x/specs.J);

wts=[0.17132449237910 0.360761573048139 0.467913934572691];
wts=[wts wts(3:-1:1)];
errorLinear = zeros(1,size(indexElementsArray,2));
errorPoly = zeros(1,size(indexElementsArray,2));
for ii=1:size(indexElementsArray,2)
    index = indexElementsArray(ii);
    specs = getSpecs;
    
    basisLinear=getBasisLinear;
    csLinear = femShallowLinear;
    [vLinear,xgLinear] = reconstructLinear(csLinear(:,end),basisLinear);
    vExactForLinear = vExact(xgLinear',specs.T);
    degreeOfFreedomLinear(ii) = specs.linearN+1;
    %errorLinear(ii) = norm(vExactForLinear-vLinear)/((specs.linearN+1))
    dx = xgLinear(2)-xgLinear(1);
    for element = 1:specs.linearN
        errorLinear(1,ii) = errorLinear(1,ii) + dx*sum(wts.*((vExactForLinear...
            (element*6-5:element*6) - vLinear(element*6-5:element*6))'.^2));
    end
    errorLinear(1,ii) = sqrt(errorLinear(1,ii))/(specs.linearN+1)
    basisPoly = getBasisPoly;
    csPoly = femShallowPoly;
    [vPoly,xgPoly] = reconstructPoly(csPoly(:,end),basisPoly);
    dx = xgPoly(2)-xgPoly(1);
    vExactForPoly = vExact(xgPoly',specs.T);
    
    degreeOfFreedomPoly(ii) = 5*specs.polyN+1;
    specs.polyN
    for element = 1:specs.polyN
        errorPoly(1,ii) = errorPoly(1,ii) + dx*sum(wts.*((vExactForPoly...
            (element*6-5:element*6) - vPoly(element*6-5:element*6))'.^2));
    end
    errorPoly(ii) = sqrt(errorPoly(ii))/(5*specs.polyN+1)
    %errorPoly(ii) = norm(vExactForPoly-vPoly)/((5*specs.polyN+1))
end

figure(4)

set(gcf,'DefaultLineLineWidth',3,'DefaultTextFontSize',12,...
    'DefaultTextFontWeight','bold','DefaultAxesFontSize',12,...
    'DefaultAxesFontWeight','bold');

% subplot(3,1,1)
% plot(degreeOfFreedomLinear,errorLinear,'b-o',...
%     degreeOfFreedomPoly,errorPoly,'g-o')
% legend('Linear','Poly')
% xlabel('(Degree of Freedom)')
% ylabel('(Error)')

subplot(3,1,3)
plot(log10(degreeOfFreedomLinear),log10(errorLinear),'b-o',...
    log10(degreeOfFreedomPoly),log10(errorPoly),'g-o')
legend('Linear','Poly')
xlabel('log(Degree of Freedom)')
ylabel('log(Error)')
grid on

