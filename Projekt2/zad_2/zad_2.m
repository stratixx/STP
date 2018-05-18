load('../dane_poczatkowe.mat');

a = exp(-Tp/T1);
b = exp(-Tp/T2);

numZ = zeros(1,3+T0/Tp);
denZ = zeros(1,3+T0/Tp);

numZ(1,length(numZ))   = (T2*(1-b)*a-T1*(1-a)*b); % c12
numZ(1,length(numZ)-1) = (T1*(1-a)-T2*(1-b));     % c11
numZ = numZ * 1/(T1-T2);

denZ(1,1) = 1;
denZ(1,2) = -(a+b); % -b1
denZ(1,3) = a*b;    % -b2

c = numZ(1,1:length(numZ));
b = -denZ(1,2:length(denZ));
%y(k) = -b(1)*y(k-1)-b(2)*y(k-2) + c(11+1)*u(k-11)+c(12+1)*u(k-12);