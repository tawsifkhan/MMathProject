%parameters for figure and panel size
plotheight=11;
plotwidth=15;
subplotsx=3;
subplotsy=2;   
leftedge=1.2;
rightedge=0.5;   
topedge=1;
bottomedge=1.5;
spacex=0.2;
spacey=0.2;
fontsize=10;    
sub_pos=subplot_pos(plotwidth,plotheight,leftedge,rightedge,bottomedge,topedge,subplotsx,subplotsy,spacex,spacey);
 
%setting the Matlab figure
f=figure('visible','on')
clf(f);
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperSize', [plotwidth plotheight]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 plotwidth plotheight]);
 
sineBasis = getBasisSine;
polyBasis = getBasisPoly;
linearBasis = getBasisLinear; 

[sineA1, sineA2]   = getStateMatrix('sine');
[linearA1, linearA2] = getStateMatrix('linear');
[polyA1, polyA2]  = getStateMatrix('poly');
sM=size(sineBasis.M,1);
sA=size(sineA2,1);
toPlot1 = [sineBasis.M linearBasis.M polyBasis.M;
          sineBasis.K linearBasis.K polyBasis.K];
toPlot2 = [sineA2 linearA2 polyA2];      
%loop to create axes
sz=3;
for i=1:subplotsx
for ii=1:subplotsy
 
ax=axes('position',sub_pos{i,ii},'XGrid','off','XMinorGrid','off','FontSize',fontsize,'Box','on','Layer','top');
if i==1
    if ii==1
        spy(sineA2,'*k',sz)
        xlabel('');
        set(gca,'XTick',[0:10:sA])
    elseif ii==2
        spy(sineBasis.M,'*k',sz)
        xlabel('');
        set(gca,'XTick',[0:5:sM])
    else
        spy(sineBasis.M,'*k',sz)
        xlabel('');
        set(gca,'XTick',[0:5:sA])
    end
end
if i==2
    if ii==1
        spy(linearA2,'*k',sz)
        xlabel('');
        set(gca,'XTick',[0:10:sA])
    elseif ii==2
        spy(linearBasis.M,'*k',sz)
        xlabel('');
        set(gca,'XTick',[0:5:sM])
    else
        spy(linearBasis.M,'*k',sz)
        xlabel('');
    end
end
if i==3
    if ii==1
        spy(polyA2,'*k',sz)
        xlabel('');
        set(gca,'XTick',[0:10:sA])
    elseif ii==2
        spy(polyBasis.M,'*k',sz)
        xlabel('');
        set(gca,'XTick',[0:5:sM])
    else
        spy(polyBasis.M,'*k',sz)
        xlabel('');
    end
end
 
if ii>1
%set(ax,'xticklabel',[])
set(gca,'XAxisLocation','top')
end
 
if i>1
set(ax,'yticklabel',[])
end
 
% % if i==1
% % ylabel(['Ylabel (',num2str(ii),')'])
% % end
% %  
% % if ii==1
% % xlabel(['Ylabel (',num2str(i),')'])
% % end
% Create textbox
annotation('textbox',...
    [0.284773060029284 0.830982367758185 0.0209370424597364 0.0705289672544081],...
    'String',{'(a.i)'},...
    'FitBoxToText','off',...
    'LineStyle','none');

% Create textbox
annotation('textbox',...
    [0.283074670571011 0.434985340876242 0.0209370424597364 0.0705289672544081],...
    'String',{'(a.ii)'},...
    'FitBoxToText','off',...
    'LineStyle','none');

% Create textbox
annotation('textbox',...
    [0.882898975109811 0.431284634760704 0.0209370424597364 0.0705289672544081],...
    'String',{'(c.ii)'},...
    'FitBoxToText','off',...
    'LineStyle','none');

% Create textbox
annotation('textbox',...
    [0.885329428989752 0.83018045174877 0.0209370424597364 0.0705289672544081],...
    'String',{'(c.i)'},...
    'FitBoxToText','off',...
    'LineStyle','none');

% Create textbox
annotation('textbox',...
    [0.586178623718889 0.829878184746251 0.0209370424597364 0.0705289672544081],...
    'String',{'(b.i)'},...
    'FitBoxToText','off',...
    'LineStyle','none');

% Create textbox
annotation('textbox',...
    [0.58301610541728 0.434261056282775 0.0209370424597364 0.0705289672544081],...
    'String',{'(b.ii)'},...
    'FitBoxToText','off',...
    'LineStyle','none');


 
end
end

%Saving eps with matlab and then marking pdf and eps and png with system commands
filename=['test'];
print(gcf, '-depsc2','-loose',[filename,'.eps']);
system(['epstopdf ',filename,'.eps'])
system(['convert -density 300 ',filename,'.eps ',filename,'.png'])
print('-depsc','-tiff','-r300','picture1');
