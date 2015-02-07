function kalmaingainplot(method,j)
specs = getSpecs;
[L,basis1] =  myKalman(method,method)

L1 = L(1:end/2);
L2 = L(end/2+1:end);
size(basis1.M)
size(basis1.K)
size(L2)
L2 = (basis1.M+specs.beta*basis1.K)\L2;
%basis = basisSelect(method);
%L = L/norm(L);
[K1, ~] = reconstructorSelect(L1,basis1,method);
[K2, x] = reconstructorSelect(L2,basis1,method);
K = K1+K2;
%save('filtergainSine.mat')
figure(8)
hold on
subplot(3,1,j)
plot(x,K,'k');
legend(sprintf('N = %s', num2str(specs.n)));
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 