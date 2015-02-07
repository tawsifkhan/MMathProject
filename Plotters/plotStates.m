clear all
file_best = strcat('special','optimal','.mat')
file_worst = strcat('special','non-optimal','.mat')
%file_best2 = strcat('Jan_19_SingleNoise_States','optimal2','.mat')
best=load(file_best);

worst = load(file_worst);

%best2=load(file_best2);

 tt = best.tt;
 specs = getSpecs;
 
%  for ii=1:size(tt,2)
%     i=i+1;
%    [vOriginal,xT] = reconstructorSelect(best.originalStates(:,(ii)),best.basisO,best.method1,best.matchN);
% 
% [vEstimated,x] = reconstructorSelect(best.estimatedStates(:,(ii)),best.basisE,best.method1,best.matchN);
% [vOriginal1,xT] = reconstructorSelect(worst.originalStates(:,(ii)),best.basisO,best.method1,best.matchN);
% 
% [vEstimated1,x] = reconstructorSelect(worst.estimatedStates(:,(ii)),best.basisE,best.method1,best.matchN);
%     figure(10)
%     clf
%     set(gcf, 'color', [1 1 1])
%     subplot(3,1,1)
%    plot(x,vOriginal,'b-',x,vEstimated,'r-','LineWidth',2);
%     axis([0 specs.J -2.5 2.5])
%     grid on
%     
%     ylabel('Displacement')
%     xlabel('x')
%     subplot(3,1,2)
%   
%     subplot(3,1,2)
%     plot(x,vOriginal1,'b-',x,vEstimated1,'r-','LineWidth',2);
% %     
% % %    e(ii)=cov(errorMatrix(:,ii));
%      axis([0 specs.J -2.5 2.5])
%      grid on
% %     
%      ylabel('Displacement')
%      xlabel('x')
% % %    titleString = sprintf('error = %.2e',e(ii));
% % %    title(titleString)
% %     %legend('Actual','Estimate')
% %     drawnow
%  end
% return
% 
% t0 = 2/specs.dt;
 t0 = 20/specs.dt;
 %t2 = 40/specs.dt;
 t1 = 120/specs.dt;
 t2 = 140/specs.dt;
 t3 = 150/specs.dt;
 %t6 = 180/specs.dt
 ttt = [t0 t1 t2 t3];
 clf
dx = specs.J/best.matchN;
i=0;
for i=1:4
ii = ttt(i)
[vOriginal,xT] = reconstructorSelect(best.originalStates(:,(ii)),best.basisO,best.method1,best.matchN);

[vEstimated,~] = reconstructorSelect(best.estimatedStates(:,(ii)),best.basisE,best.method1,best.matchN);
[vOriginal1,xT] = reconstructorSelect(worst.originalStates(:,(ii)),best.basisO,best.method1,best.matchN);

[vEstimated1,~] = reconstructorSelect(worst.estimatedStates(:,(ii)),best.basisE,best.method1,best.matchN);
subplot(2,4,i)
plot(xT,vOriginal,'-k','LineWidth',2)
%axis([0 specs.J -2.5 2.5])
hold on 
plot(xT,vEstimated,'--k','LineWidth',2)
axis([0 specs.J -2.5 2.5])
subplot(2,4,i+4)
plot(xT,vOriginal1,'-k','LineWidth',2)
%axis([0 specs.J -1 1])
hold on 
plot(xT,vEstimated1,'--k','LineWidth',2)
axis([0 specs.J -2.5 2.5])


end
return
% % 
% % [vOriginalBeta,xT] = reconstructorSelect(worst.originalStates(:,ii),worst.basis1,worst.method1,best.matchN);
% % 
% % [vEstimatedBeta,~] = reconstructorSelect(worst.estimatedStates(:,ii),worst.basis1,worst.method1,best.matchN);
% 
% % 
% % errorNoBeta(i) = norm(vOriginalBeta - vEstimatedBeta)*dx/norm(vOriginalBeta);
% % errorBeta(i) = norm((vOriginalNoBeta - vEstimatedNoBeta))*dx/norm(vOriginalNoBeta);
% % errorNoBetaL2(i) = sum(((vOriginalBeta - vEstimatedBeta)./vOriginalBeta).^2);
% % errorBetaL2(i) = sum(((vOriginalNoBeta - vEstimatedNoBeta)./vOriginalNoBeta).^2);
% % errorNoBetaL2(i) = sqrt(errorNoBetaL2(i)*dx);
% % errorBetaL2(i) = sqrt(errorBetaL2(i)*dx);
% 
% 
% 
% % figure(13)
% % clf
% % set(gcf,'DefaultLineLineWidth',2)
% % 
% % subplot(2,1,1)
% % plot(tt(1:100:end),errorNoBeta,tt(1:100:end),errorBeta)
% % subplot(2,1,2)
% % plot(tt(1:100:end),errorNoBetaL2,tt(1:100:end),errorBetaL2)
% return
% subplot(2,4,ii)
% set(gcf,'DefaultLineLineWidth',2)
% k1 = 5;
% k2 = 6;
% k3 = 10;
% h1 = plot(xT,vOriginalBeta);
% hold on
% h2 = plot(x,vEstimateNoBeta);
% axis([0 5 -1 1])
% legend('True','Estimated(Optimal)')
% set(gca,'YTick',[-1:.2:1])
% subplot(2,4,ii+4)
% h3 = plot(xT,vOriginalNoBeta);
% hold on
% h4 = plot(x,vEstimateWorst);
% axis([0 5 -1 1])
% h= [h1 h2 h3 h4];
% set(gca,'YTick',[-1:.2:1])
% legend('True','Estimated(Non-Optimal)')
% set(h1,'LineStyle','-','Color',[0 0 0]+0.05*k1,'LineWidth',2)
% set(h2,'LineStyle','--','Color',[0 0 0]+0.05*k1,'LineWidth',2)
% set(h3,'LineStyle','-','Color',[0 0 0]+0.05*k1,'LineWidth',2)
% set(h4,'LineStyle','--','Color',[0 0 0]+0.05*k1,'LineWidth',2)
% 
% 
% 
% 
% return
% % subplot(2,1,2)
% % plot(xT,vTrue,'k',x,vEstimateBest,'--k')
% % subplot(2,1,1)
% % plot(xT,vTrue,'k',x,vEstimateWorst,'--k')
% % 
% % figure(12) 
% % ii=t2;
% % [vTrue,xT] = reconstructorSelect(trueStates(:,ii),basisT,method2,matchN);
% % [vEstimateBest,~] = reconstructorSelect(best.estimatedStates(:,ii),basis1,method1,matchN);
% % [vEstimateWorst,x] = reconstructorSelect(worst.estimatedStates(:,ii),basis1,method1,matchN);
% % 
% % subplot(2,1,2)
% % plot(xT,vTrue,'k',x,vEstimateBest,'--k')
% % subplot(2,1,1)
% % plot(xT,vTrue,'k',x,vEstimateWorst,'--k')
% % figure(13)
 eBestSum = 0;
 eWorstSum = 0;
 eBest2Sum = 0;
% TT=1;%2000;
errorMatrix1=best.originalStates - best.estimatedStates;
errorMatrix2=worst.originalStates - worst.estimatedStates;
errorMatrix3=best2.originalStates - best2.estimatedStates;
for ii=1:1:size(tt,2)
    eBest(ii)=trace(cov(errorMatrix1(:,ii)*errorMatrix1(:,ii)'));
    eBestSum = eBestSum + eBest(ii);%*specs.dt/TT;
    eWorst(ii)=trace(cov(errorMatrix2(:,ii)*errorMatrix2(:,ii)'));
    eWorstSum = eWorstSum + eWorst(ii);%*specs.dt/TT;
    eBest2(ii)=trace(cov(errorMatrix3(:,ii)*errorMatrix3(:,ii)'));
    eBest2Sum = eBest2Sum + eBest2(ii);%*specs.dt/TT;
end

norm(eWorst(1)-eBestSum(1));
figure(10)

%subplot(2,1,2)
toSkip = 40;

plot(tt(1:toSkip:end),log10(eBest(1:toSkip:end)),'-r',tt(1:toSkip:end),log10(eWorst(1:toSkip:end)),'-g',tt(1:toSkip:end),log10(eBest2(1:toSkip:end)),'-b')
