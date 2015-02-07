clear all
best = load('data1.mat');
best2 = load('data3.mat');
worst = load('data2.mat');
tt = best.tt;
j=0;
for i=1:200:size(tt,2)
    j=j+1;
    cov1(j) = cov(best.errorMatrix(:,i));
     cov3(j) = cov(best2.errorMatrix(:,i));
      cov2(j) = cov(worst.errorMatrix(:,i));
      ttt(j) = tt(i);
end
plot(ttt,cov1,ttt,cov2,ttt,cov3)
return
% (best.C1*best.G1')
% 
% (best2.C1*best2.G1')
% (worst.C1*worst.G1')
% 
% 
% % figure(1)
% for i=1:size(tt,2)
%     
%     'Working...'
%     dy1(i) = norm(best.y(i)-best.C1*best.estimatedStates(:,i));
%     dy2(i) = norm(worst.y(i)-worst.C1*worst.estimatedStates(:,i));
%     dy3(i) = best2.C1*(best2.originalStates(:,i)-best2.estimatedStates(:,i))+best2.w2(i);
%     noisediff(i) = best.w2(i) - worst.w2(i);
% end
% max(dy1)
% max(dy2)
% figure(2)
% clf
% plot(tt,dy1,tt,dy2)
% return
% subplot(4,1,1)
% plot(tt(1:10:end),y(1:10:end),tt(1:10:end),yy(1:10:end))


% 
% subplot(4,1,2)
% plot(xT,vTrue,'k',x,vEstimate,'--k')
% clear all
% load('dataSpecial2.mat')
% ii=0;
% for i=1:2000
%     ii=ii+1
%     yy(i) = C1*estimatedStates(:,i);
%     y(i) = C1*originalStates(:,i);
%     diff(i) = yy(i) - y(i);
%     %noise(i) = G*w1(i);
%     [vTrue,xT] = reconstructorSelect(originalStates(:,i),basis1,method1,1000);
%     [vEstimate,~] = reconstructorSelect(estimatedStates(:,i),basis1,method1,1000);
%     error(i) = norm(vTrue - vEstimate)/6000;
% end
% cov(diff)


figure(10)
subplot(3,1,1)
plot(tt(1:2000),diff)
subplot(3,1,3) 
plot(tt(1:2000),y,tt(1:2000),yy)
subplot(3,1,2)
plot(tt(1:2000),error)