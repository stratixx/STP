load('../dane_poczatkowe.mat');

a = exp(-Tp/T1);
b = exp(-Tp/T2);

numZ = zeros(1,3+T0/Tp);
denZ = zeros(1,3+T0/Tp);

numZ(1,length(numZ))   = (T2*(1-b)*a-T1*(1-a)*b); % c12
numZ(1,length(numZ)-1) = (T1*(1-a)-T2*(1-b));     % c11
numZ = numZ * K0/(T1-T2);

denZ(1,1) = 1;
denZ(1,2) = -(a+b); % -b1
denZ(1,3) = a*b;    % -b2

c = numZ(1,1:length(numZ));
b = denZ(1,2:length(denZ));
%y(k) = -b(1)*y(k-1)-b(2)*y(k-2) + c(11+1)*u(k-11)+c(12+1)*u(k-12);

% parametry PID
Kk = 0.38623;
Tk = 20;

Kr = 0.6*Kk;
Ti = 0.5*Tk;
Td = 0.12*Tk;

r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r2 = Kr*Td/Tp;

%inicjalizacja
regulator = 'PID';
start = 13;
kk=400; %koniec symulacji
%warunki pocztkowe
u=zeros(1,kk);
y=zeros(1,kk);
e=zeros(1,kk);
yzad=zeros(1,kk); yzad(1,start:kk)=1;

for k=start:kk; %g³ówna ptla symulacyjna
    %symulacja obiektu
    y(k) = -b(1)*y(k-1)-b(2)*y(k-2) + c(11+1)*u(k-11)+c(12+1)*u(k-12);
    %uchyb regulacji
    e(k)=yzad(k)-y(k);
    %sygna³ sterujcy regulatora PID
    u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
end
s = u(13:83);