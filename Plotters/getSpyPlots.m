sineBasis = getBasisSine;
polyBasis = getBasisPoly;
linearBasis = getBasisLinear; 

[sineA1, sineA2]   = getStateMatrix('sine');
[linearA1, linearA2] = getStateMatrix('linear');
[polyA1, polyA2]  = getStateMatrix('poly');
figure(5)
clf

subplot(3,3,1)
    spy(sineBasis.M,3)
subplot(3,3,2)
    spy(linearBasis.M,3)
subplot(3,3,3)
    spy(polyBasis.M,3)

subplot(3,3,4)
    spy(sineBasis.K,3)
subplot(3,3,5)
    spy(linearBasis.K,8)
subplot(3,3,6)
    spy(polyBasis.K,3)

subplot(3,3,7)
    spy(sineA2,3)
subplot(3,3,8)
    spy(linearA2,3)
subplot(3,3,9)
    spy(polyA2,3)
