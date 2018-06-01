run('../zad_2/zad_2.m');

% parametry DMC
% horyzont dynamiki wyznaczony z odpowiedzi skokowej
% jako zmiana od 10 do 90%
D = length(s); 
N=4;
Nu=1;
lambda = 400;
for lambda=1000:-50:50

%inicjalizacja symulacji
start = 100;
kk=689; %koniec symulacji
%warunki pocztkowe
u=zeros(1,kk);
y=zeros(1,kk);
yzad=zeros(1,kk+D); yzad(1,start+25:kk+100)=1;

M = zeros(D,D);
for kNu=1:Nu
    M(kNu:N,kNu) = s(1:(N+1-kNu));
end

Mp = ones(D,D-1)*s(end);
for kD=1:D-1
    Mp(1:(N-kD),kD) = s((kD+1):(N))';
end
Mp = Mp - ones(D,1)*s(1:end-1);

fi = eye(D);
LAMBDA = lambda*eye(D);
K = inv((M')*M+LAMBDA)*(M');
deltaUp = zeros(kk,1);

for k=start:kk; %g³ówna ptla symulacyjna
    %symulacja obiektu
    y(k) = -b(1)*y(k-1)-b(2)*y(k-2) + c(11+1)*u(k-11)+c(12+1)*u(k-12);    
    %sygna³ sterujcy regulatora DMC        
    yo = y(k)*ones(D,1)+Mp*flip(deltaUp((k-D+1):(k-1)));
    deltau = K*(yzad(k:(k+D-1))'-yo);
    deltaUp(k) = deltau(1);
    u(k) = u(k-1)+deltau(1);
end;
%wyniki symulacji
uDMC = u; yDMC = y;
figure; 
hold on; 
 
stairs((1:(kk-start+10+1))*Tp, uDMC((start-10):kk));
title('Wykres sterowania obiektu'); xlabel('Czas(s)'); ylabel('Wartoœæ'); 
grid on; box on; legend('u_D_M_C', 'Location', 'southeast');
print(strcat('img/d/wykresy_u/u_D_',num2str(D),'_lambda_',num2str(lambda),'_N_',num2str(N),'_Nu_',num2str(Nu)), '-dpng');
close;
figure; hold on; 
stairs((1:kk-start+10+1)*Tp, yDMC(start-10:kk)); 
stairs((1:kk-start+10+1)*Tp, yzad(start-10:kk)); 
grid on; box on;
title('Wykres wyjœcia obiektu'); 
xlabel('Czas(s)'); ylabel('Wartoœæ'); 
legend('y_D_M_C', 'y_z_a_d', 'Location', 'southeast');
print(strcat('img/d/wykresy_y/y_D_',num2str(D),'_lambda_',num2str(lambda),'_N_',num2str(N),'_Nu_',num2str(Nu)), '-dpng');
close;
end;