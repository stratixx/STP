K0 = 5.7;
T0 = 5;
T1 = 2.07;
T2 = 4.95;
Tp = 0.5;

s = tf('s');
Gs = K0*exp(-T0*s) / ( (T1*s+1)*(T2*s+1) );

A = T1*T2/(T1-T2);
B = -A;

a = exp(-Tp/T1);
b = exp(-Tp/T2);

z = tf('z', Tp);
Gz = K0/(T1-T2) * ( (T1*(1-a)-T2*(1-b))*z^(-1-T0/Tp) + (T2*(1-b)*a-T1*(1-a)*b)*z^(-2-T0/Tp) )/( 1-(a+b)*z^(-2) + a*b*z^(-2) )

numZ = zeros(1,3+T0/Tp);
denZ = zeros(1,3+T0/Tp);

numZ(1,length(numZ))   = (T2*(1-b)*a-T1*(1-a)*b);
numZ(1,length(numZ)-1) = (T1*(1-a)-T2*(1-b));
numZ = numZ * 1/(T1-T2);

denZ(1,1) = 1;
denZ(1,2) = -(a+b);
denZ(1,3) = a*b;

figure(1);
step(Gs,'b',Gz,'g');
legend('Transmitancja ci�g�a', 'Transmitancja dyskretna', 'Location', 'southeast');
xlabel('Czas');
ylabel('Warto��');
title('Odpowied� skokowa transmitancji');
box on; grid on;
