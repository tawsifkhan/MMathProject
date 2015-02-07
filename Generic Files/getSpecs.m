function specs = getSpecs

% This functions returns a structure containing all the Physical and
% Computational Parameters of the problem.

global index;     % Index to pick a certain Degree of Freedom(DoF).  

%DoF index        1  2  3   4   5   6   7   8   9  10    
%                --------------------------------------
%sineModes     = [26,51,76,101,126,151,176,201,226,251];
%elementsLinear= [25,50,75,100,125,150,175,200,225,250];
%elementsPoly  = [ 5,10,15, 20, 25, 30, 35, 40, 45, 50];
%                --------------------------------------   

index = 5;                          % Selects a Degree of Freedom
                                    % For reference see the above table

                                    
sineModes     = index*5*5+1;        % Number of modes for sine basis
linearN       = index*5*5;          % Number of elements for linear method
polyN         = index*5;            % Number of elements for 6th order method

sineN         = 1000;               % Number of elements for sine basis.
                                    % This is only used to evaluate and
                                    % plot results.

sineModesTrue = 500;                % Number of sine modes for true system
sineTrueN     = 100;
 

J=5;                            % Length of domain (0 to J)
H=0.05;                         % Hydrostatic Constant
c2=9.81*H;                      % Wave Speed Squared
c = sqrt(c2);                   % Wave Speed
beta=H*H/6;                     % Beta
cd=0.0025;                      % Damping Constant
dt=.05;                         % Delta t
dt2=dt*dt;                      % Delta t squared
t=0; T=20;                      % Initial and final times
numsteps=1;                     % Number of iterations
numouts=(T/dt*numsteps)+1;      % Number of nested iterations which will plot results
toPlot=1;                       % 1 will plot results in FEM codes
                                % 0 will NOT plot results in FEM codes
% Initial Conditions 
v0=@(x) sech(J/2*(x-J*0.5));     
%v0=@(x) 0.2*(sin(pi*x/(0.8))+sin(pi*x/(2))).*sech((x-0.5*J)/4).^8;
%v0=@(x) 0.5*cos(x/J).*(1+sin(x/J));
%v0=@(x) sin(2*pi*x/J)+sin(3*pi*x/J);

v0_t=@(x) 0*x;                  

% Return the following Structure
specs=struct('n',sineModes,         ...
             'nTrue',sineModesTrue, ...
             'linearN',linearN,     ...
             'polyN',polyN,         ...
             'sineN',sineN,         ...
             'sineTrueN',sineTrueN, ...
             'J',J,                 ...
             'c',c,                 ...
             'c2',c2,               ...
             'H',H,                 ...
             'beta',beta,           ...
             'cd',cd,               ...
             'numsteps',numsteps,   ...
             'numouts',numouts,     ...
             'dt',dt,               ...
             'dt2',dt2,             ...
             't',t,                 ...
             'T',T,                 ...  
             'v0',v0,               ...
             'v0_t',v0_t,           ...
             'toPlot',toPlot);
end