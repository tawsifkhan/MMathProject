function makeeps(filename,device)
% This file saves the figures in my requested locations. device = 'mac' or
% 'windows'

if strcmp(device,'mac')==1
cd('/Users/t35khan/Dropbox/Tawsif/Codes/MyProject_Linear_SingleNoise/Figures')
end
if strcmp(device,'pc')==1
cd('C:\Users\Tawsif\Dropbox\Tawsif\Codes\MyProject_Linear_SingleNoise\Figures')
end
if strcmp(device,'mac')==1
cd('/Users/t35khan/Dropbox/Tawsif/Writing/Thesis(Main)')
end
if strcmp(device,'pc')==1
cd('C:\Users\Tawsif\Dropbox\Tawsif\Writing\Thesis(Main)')
end


print(gcf, '-depsc2',[filename,'.eps']);
print(gcf,'-dpdf','-r300','-loose',strcat(filename,'.pdf'))
%system(['epstopdf ',filename,'.pdf'])
system(['convert -density 300 ',filename,'.eps '])

if strcmp(device,'mac')==1
cd('/Users/t35khan/Dropbox/Tawsif/Codes/MyProject_Linear_SingleNoise')
end
if strcmp(device,'pc')==1
cd('C:\Users\Tawsif\Dropbox\Tawsif\Codes\MyProject_Linear_SingleNoise')
end