% This file creates a data set of random noise. In order to compare different
% methods this 'noise.mat' can be reused to get the same states for
% comparison

clear all
specs = getSpecs;

RR = .0001; % Sensor Disturbance Variance [Ignore the scaling]
QQ = 100;   % System Disturbance Variance [Ignore the scaling]

tt=0:specs.dt:specs.T;
m = size(tt,2);

w1 = sqrt(QQ)*randn(1,m); % Create the noise set
w1= w1 - mean(w1);
w2 = sqrt(RR)*randn(m,1);
w2 = w2 - mean(w2);

Ze0 = randn(2*specs.n,1)/1000;
Ze0 = Ze0 - mean(Ze0);
save('noise.mat')