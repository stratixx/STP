run('../zad_2/zad_2.m');

% parametry DMC
% horyzont dynamiki wyznaczony z odpowiedzi skokowej
% jako zmiana od startu do 90%
D = length(s); 
N=12;
Nu=1;
lambda = 6.9;
for k=1:1:1 % podpunkt a
%for N=D:-1:1 % podpunkt b
%    Nu=N;
%for Nu=1:1:N % podpunkt c
%vectLambda = 0.1501:0.001:0.1601;
%for kLambda=1:1:length(vectLambda) % podpunkt d
%lambda = vectLambda(kLambda);
%inicjalizacja symulacji
start = 100;
kk=289; %koniec symulacji
%warunki pocztkowe
u=zeros(1,kk);
y=zeros(1,kk);
yzad=zeros(1,kk+D); yzad(1,start+25:kk+100)=1;

run('../zad_4/DMC_init.m');

for k=start:kk; %g³ówna ptla symulacyjna
    %symulacja obiektu
    y(k) = -y((k-length(b)):(k-1))*(flip(b')) + u((k-length(c)+1):(k))*(flip(c'));  
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
%print(strcat('img/a/wykresy_u/u_D_',num2str(D),'_lambda_',strrep(num2str(lambda),'.','_'),'_N_',num2str(N),'_Nu_',num2str(Nu)), '-dpng');
%close;
figure; hold on; 
stairs((1:kk-start+10+1)*Tp, yDMC(start-10:kk)); 
stairs((1:kk-start+10+1)*Tp, yzad(start-10:kk)); 
grid on; box on;
title('Wykres wyjœcia obiektu'); 
xlabel('Czas(s)'); ylabel('Wartoœæ'); 
legend('y_D_M_C', 'y_z_a_d', 'Location', 'southeast');
%print(strcat('img/a/wykresy_y/y_D_',num2str(D),'_lambda_',strrep(num2str(lambda),'.','_'),'_N_',num2str(N),'_Nu_',num2str(Nu)), '-dpng');
%close;
end;