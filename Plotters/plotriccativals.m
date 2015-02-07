load('riccatiValspoly.mat')
m1 = 'Sine'
m2 = 'Linear'
m3 = '6^{th} Order'

figure(10)
subplot(2,1,1)
DoF = [1:5]*5+1
plot(log10(DoF),ttime(1:5),'k-D')
xlabel('log(Degree of Freedom)')
ylabel('time')
legend(m1,m2,m3)
hold on
subplot(2,1,2)
plot(log10(DoF),resdA(1:5),'k-D')
xlabel('log(Degree of Freedom)')
ylabel('Norm of Residual')

legend(m1,m2,m3)
hold on