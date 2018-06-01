run('../zad_2/zad_2.m');

%inicjalizacja symulacji
regulator = 'DMC';
start = 100;
kk=620; %koniec symulacji
%warunki pocztkowe
u=zeros(1,kk);
y=zeros(1,kk);
e=zeros(1,kk);
yzad=zeros(1,kk+100); yzad(1,start+25:kk+100)=1;

% parametry PID
Kk = 0.38623;
Tk = 20;

Kr = 0.6*Kk;
Ti = 0.5*Tk;
Td = 0.12*Tk;

r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r2 = Kr*Td/Tp;

% parametry DMC
%s = [0.3, 0.6, 0.9];
D = length(s);%60; % horyzont dynamiki
N=4;
Nu=4;

M = zeros(D,D);
for kNu=1:Nu
    M(kNu:N,kNu) = s(1:(N+1-kNu));
end

Mp = ones(D,D-1)*s(end);
for kD=1:D-1
    Mp(1:(N-kD),kD) = s((kD+1):(N))';
end
Mp = Mp - ones(D,1)*s(1:end-1);

lambda = 400
fi = eye(D);
LAMBDA = lambda*eye(D);
K = inv((M')*M+LAMBDA)*(M');
deltaUp = zeros(kk,1);

for k=start:kk; %g³ówna ptla symulacyjna
    %symulacja obiektu
    y(k) = -b(1)*y(k-1)-b(2)*y(k-2) + c(11+1)*u(k-11)+c(12+1)*u(k-12);

    if regulator == 'PID'
        %uchyb regulacji
        e(k)=yzad(k)-y(k);
        %sygna³ sterujcy regulatora PID
        u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
    end;
    
    if regulator == 'DMC'
        %sygna³ sterujcy regulatora DMC
        
        yo = y(k)*ones(D,1)+Mp*flip(deltaUp((k-D+1):(k-1)));
        deltau = K*(yzad(k:(k+D-1))'-yo);
        deltaUp(k) = deltau(1);
        u(k) = u(k-1)+deltau(1);
    end
end;
%wyniki symulacji
if regulator == 'DMC'
    uDMC = u; yDMC = y;
end
if regulator == 'PID'
    uPID = u; yPID = y;
end
figure; 
hold on; 

stairs((1:kk)*Tp, uPID); 
stairs((1:kk)*Tp, uDMC);
title('Wykres sterowania obiektu'); xlabel('Czas(s)'); ylabel('Wartoœæ'); 
grid on; box on; legend('u_P_I_D', 'u_D_M_C');
print('img/wykres_u', '-dpng');
figure; hold on; 
stairs((1:kk)*Tp, yPID); 
stairs((1:kk)*Tp, yDMC); 
stairs((1:kk)*Tp, yzad(1:kk)); 
grid on; box on;
title('Wykres wyjœcia obiektu'); 
xlabel('Czas(s)'); ylabel('Wartoœæ'); 
legend('y_P_I_D', 'y_D_M_C', 'y_z_a_d');
print('img/wykres_y', '-dpng');