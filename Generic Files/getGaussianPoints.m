function xg=getGaussianPoints(x,numberOfElements)
% This functions creates the Gaussian points which is required for the
% integration in the Finite Element methods

xi=[-0.932469514203152 -0.661209386466265 -0.238619186083197 ...
    0.238619186083197 0.661209386466265 0.932469514203152];
for kk=1:numberOfElements,
    xp=x(kk+1); xm=x(kk); dx=xp-xm;
    xg(1+(kk-1)*6:kk*6)=xm+(xi+1)*0.5*dx;
end
end