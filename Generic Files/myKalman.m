function [L, basisE]=myKalman(method1,method2)

% This function performs state estimation using the Kalman filter method.
% Two discretization methods(sine and linear/poly) can be given as arguments for comparison
% Need to run noisefile.m if noise parameters are changed

noise = load('noise.mat');          % Load Noise file for simulation
lArray =2.39;%1.5:.01:4.5;          % Array of sensor locations/One location
savefile = 1;                       % Saves only estimator parameters if set to 1
savefile2= 1;                       % Saves state estimates also if set to 1

specs= getSpecs;                    % Problem specifications
tt=0:specs.dt:specs.T;              % Time instants

switch lower(method1)               % This tells how many x values to reconstruct on using sine functions
    case {'sine'},      matchN = specs.sineN;
    case {'linear'},    matchN = specs.linearN;
    case {'poly'},      matchN = specs.polyN;
end

basisE=basisSelect(method1,matchN);             % Basis for the estimator
basisO=basisSelect(method2,matchN);             % Basis for the true system

[A1_E,A2_E] = getStateMatrix(method1);          % State Matrices using both basis
[A1_O,A2_O] = getStateMatrix(method2);

nE = specs.n;                                   % DoF Estimator
nO = nE;                                        % DoF Original/True

x = linspace(0,specs.J,matchN+1);               % x for estimate solution
x = getGaussianPoints(x,matchN);                % gaussian points
Zo0 = [getCoEffsSelect(specs.v0(x)',basisO,method2); zeros(nO,1)];
Ze0= noise.Ze0;

% Read noise characteristics from noisefile
QQ = noise.QQ;
RR = noise.RR;
[G2_O,G1_O] = disturbance(method2);
[G2_E, G1_E] = disturbance(method1);

Ge = [G1_E' ; G2_E'];
G  = [G1_O' ; G2_O'];

for sL = 1:size(lArray,2)
    l = lArray(sL);
    [C1_E,C2_E] = mySensor2(method1,l);         % Observation matries C =[C1 C2]
    [C1_O,~] = mySensor2(method2,l);
    
    % Computing the Q matrix for estimator. The size is smaller than the
    % true system noise and hence it needs to be taken care of.
    % Q_E = [QQ(1:nE,1:nE) zeros(1:nE,1:nE); zeros(1:nE,1:nE) QQ((nO+1):(nO+1)+nE,(nO+1):(nO+1)+nE)]
    
    % Create Riccati Equation
    Q = Ge*(QQ*(Ge'));
    R = RR;
    S = zeros(nE+nE,1);
    
    fprintf('Solving Riccati Equation')
    [X,~,L,~] = care(full(A2_E)',[C1_E C2_E]',(Q+Q')/2,R,S,full(A1_E)');
    cost(sL) = trace(X);
    L = L'; % Kalman gain
    %return
end
if savefile==1
    jj = num2str(d);
    filename = strcat('checkspecial',jj,'.mat');
    save(filename);
end
%return

% Construct and solve the ODE for the original system
original = @(t1,Z) A2_O*Z + G*(interp1(tt,noise.w1,t1,'spline'))';
options = odeset('Mass',A1_O);
fprintf('Solving Original System')
[~, Z] = ode15s(original,tt,Zo0,options);
Z = Z';
originalStates = Z(1:nO,:);

% Compute measurements
for i=1:size(tt,2), y(:,i) = C1_O*Z(1:nO,i)+noise.w2(i,1); end 

% Construct the ODE for the original system
estimator = @(t2,Ze) (A2_E-L*[C1_E C2_E])*Ze+ L*(interp1(tt,y,t2,'spline'));
options = odeset('Mass',A1_E);
fprintf('Solving Estimator')
[~,Ze]= ode15s(estimator,tt,Ze0,options);
Ze= Ze';
estimatedStates = Ze(1:nE,:);

frpintf('Solving Original System Without Noise')
true = @(t1,ZZ) A2_O*ZZ;%+ GT*(interp1(tt,w1,t1,'spline'))';
options = odeset('Mass',A1_O);
[~,ZZ]= ode15s(true,tt,Zo0,options);
ZZ=ZZ';
trueStates = ZZ(1:nO,:);


if savefile2==1
    filename = strcat('special','optimal','.mat');
    save(filename);
end
%return

i=0;
for ii=1:size(tt,2)
    i=i+1;
    [noiseF,x] =  reconstructorSelect(G2_O*noise.w1(i),basisO,method1,matchN);
    [vOriginal,x] = reconstructorSelect(originalStates(:,ii),basisO,method2,matchN);
    [vEstimate,x] = reconstructorSelect(estimatedStates(:,ii),basisE,method1,matchN);
    [vTrue, xT] = reconstructorSelect(trueStates(:,ii),basisO,method2,matchN);
    
    figure(10)
    clf
    set(gcf, 'color', [1 1 1])
    subplot(3,1,1)
    plot(x,vTrue,'LineWidth',2)
    axis([0 specs.J -2 2])
    grid on
    
    ylabel('Displacement')
    xlabel('x')
    subplot(3,1,2)
    plot(x,noiseF,'LineWidth',2)
    axis([0 specs.J -.05 .05])
    grid on
    
    ylabel('Displacement')
    xlabel('x')
    subplot(3,1,3)
    plot(x,vOriginal,'b-',x,vEstimate,'r-','LineWidth',2);
    axis([0 specs.J -2 2])
    grid on
    
    ylabel('Displacement')
    xlabel('x')
    
end
end
