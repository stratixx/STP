 run('../zad_2/zad_2.m');

Kk = 0.3862;
Tk = 20;

Kr = 0.6*Kk;
Ti = 0.5*Tk;
Td = 0.12*Tk;

r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r2 = Kr*Td/Tp;

%inicjalizacja
start = 13;
kk=600; %koniec symulacji
%warunki pocztkowe
u=zeros(1,kk);
y=zeros(1,kk);
e=zeros(1,kk);
yzad=zeros(1,kk); yzad(1,50:kk)=1;

regulator = 'DMC';
D = 500; % horyzont dynamiki
lambda = 1;
Nu = D; % horyzont sterowania
N = D % horyzont predykcji


for k=start:kk; %g³ówna ptla symulacyjna
    %symulacja obiektu
    y(k) = -b(1)*y(k-1)-b(2)*y(k-2) + c(11+1)*u(k-11)+c(12+1)*u(k-12);
    %uchyb regulacji
    e(k)=yzad(k)-y(k);

    if regulator == 'PID'
        %sygna³ sterujcy regulatora PID
        u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
    end;
    
    if regulator == 'DMC'
        %sygna³ sterujcy regulatora PID
        u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
    end
end;
%wyniki symulacji
figure; stairs(u);
title('u'); xlabel('k'); grid on; box on;
figure; hold on; stairs(y); stairs(yzad); grid on; box on;
title('yzad, y'); xlabel('k'); legend('y', 'yzad');