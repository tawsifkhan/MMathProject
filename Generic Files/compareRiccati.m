function [ttime, resdA, resdM] = compareRiccati(method)
% This file used to record time required for MATLAB function CARE to solve
% the Algebraic Riccati Equation
global index
jj =0;
for i=1:5
    jj=jj+1;
    index=i;
    [A1,A2]=getStateMatrix(method);
    [C1,C2]=mySensor2(method,1.5);
    [G1,G2] = disturbance(method);
    QQ=10;
    R=.0001;
    C=[C1 C2];
    G=[G2 G1]';
    Q=G*(QQ*(G'));
    n = 2*(index*5*5+1);
    S = zeros(n,1);
    ttime(jj) = 0;
    resdA(jj) = 0;
    resdM(jj) = 0;
    for j = 1:5
    tic
    [X,~,L,autoResd] = care(full(A2)',[C1 C2]',(Q+Q')/2,R,S,full(A1)');
    ttime(jj)=toc+ttime(jj);
    manResd = A2*X*A1' + A1*X*A2' - (A1*X*C')*(1/R)*(C*X*A1')+Q;
    manResd = norm(manResd);
    resdM(jj)= manResd+resdM(jj);
    resdA(jj)=autoResd+resdA(jj);
    end
    ttime(jj) = ttime(jj)/5;
    resdA(jj) = resdA(jj)/5;
    resdM(jj) = resdM(jj)/5;
    clearvars -except ttime index resdA resdM iterations DoF method jj
end
filename = strcat('riccatiVals',method,'.mat');
save(filename)
