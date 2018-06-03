load('../dane_poczatkowe.mat');

s = tf('s');
Gs = K0*exp(-T0*s) / ( (T1*s+1)*(T2*s+1) );
s = 0;
KstatS = K0*exp(-T0*s) / ( (T1*s+1)*(T2*s+1) );

a = exp(-Tp/T1);
b = exp(-Tp/T2);
z = tf('z', Tp);
Gz = K0/(T1-T2) * ( (T1*(1-a)-T2*(1-b))*z^(-1-T0/Tp) + (T2*(1-b)*a-T1*(1-a)*b)*z^(-2-T0/Tp) )/( 1-(a+b)*z^(-2) + a*b*z^(-2) );
z = 1;
KstatZ = K0/(T1-T2) * ( (T1*(1-a)-T2*(1-b))*z^(-1-T0/Tp) + (T2*(1-b)*a-T1*(1-a)*b)*z^(-2-T0/Tp) )/( 1-(a+b)*z^(-2) + a*b*z^(-2) );
%nie umiesz w algebrê czy coœ typie

Gz = c2d(Gs,Tp,'zoh');
figure(1);
hold on;
step(Gs,'b',Gz, 'g');
legend('Transmitancja ci¹g³a', 'Transmitancja dyskretna', 'Location', 'southeast');
xlabel('Czas');
ylabel('Wartoœæ');
title('OdpowiedŸ skokowa transmitancji');
box on; grid on;
%print('img/odp_skokowa_modeli', '-dpng');
%close 1;
Gz
KstatS
KstatZ