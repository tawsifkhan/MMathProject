clear all
figure(5)
clf
i=0;
modes = [2.3:.01:2.7];
for j=1:size(modes,2)
filename = strcat('checkspecial',num2str(modes(j)),'.mat');
%filename = strcat('Dec09_constantVar_modes_',num2str(modes(j)),'.mat');


load(filename)
cost = cost/max(cost);
cost = round(cost.* 10^8) ./ 10^8;
%for j=1:length(modes)
%      subplot(2,1,2)
%      plot(lArray(1:10:end),cost(1:10:end))
%      hold on
% end
hold on

[aa,bb] = min(cost);
osl(j) =  lArray(bb)
end
%return
subplot(2,1,1)
h1=scatter(modes, osl);
%h1.Marker = 'x'; h1.Color = 'r';
hold on
h2 = scatter(modes,modes);
%h2.Marker = 'o'; h2.Color = 'b';

osl
return
for j=1:size(modes,2)
filename = strcat('Dec09_constantVar_nm_all_modes_',num2str(modes(j)),'.mat');
%filename = strcat('Dec09_constantVar_modes_',num2str(modes(j)),'.mat');

load(filename)
cost = cost/max(cost);
cost = round(cost.* 10^10) ./ 10^10;
if j==length(modes)
    subplot(3,2,4)
    plot(lArray,cost)
end

[aa,bb] = min(cost);
osl(j) =  lArray(bb);

end
subplot(3,2,3)
scatter(modes, osl)

for j=1:size(modes,2)
filename = strcat('Dec09_constantVar_nm_10_modes_',num2str(modes(j)),'.mat');
%filename = strcat('Dec09_constantVar_modes_',num2str(modes(j)),'.mat');

load(filename)
cost = cost/max(cost);
cost = round(cost.* 10^11) ./ 10^11;
if j==length(modes)
    subplot(3,2,6)
    plot(lArray,cost)
end
[aa,bb] = min(cost);
osl(j) =  lArray(bb);

end
subplot(3,2,5)
scatter(modes, osl)


return

