load('../dane_poczatkowe.mat');
run('../zad_2/zad_2.m');

% parametry DMC
% horyzont dynamiki wyznaczony z odpowiedzi skokowej
% jako zmiana od startu do 90%
run('../zad_4/step_response.m');
D = length(s); 
Nvect=[12,16,17,37,43];%[12]; 
Nuvect=[1,2,6,12,43];%dla N=D
%Nuvect=[1,2,6,8,12];%dla N=12
lambdavect = [0.25,0.75,1,2.5,7.5]; %[1]

% wyb�r p�tli do konkretnego podpunktu
%for k=1:1:1                        % podpunkt a
 %   N=D; Nu=D; lambda=1;
%for kN=1:1:length(Nvect)           % podpunkt b
    %N = Nvect(kN);  Nu=N; lambda=1;
%for kNu=1:1:length(Nuvect)         % podpunkt c
    %Nu = Nuvect(kNu);  N=D; lambda=1;
for kLambda=1:1:length(lambdavect)  % podpunkt d
    lambda = lambdavect(kLambda); N=12; Nu=1; 

%inicjalizacja symulacji
start = 100;
kk=229; %koniec symulacji
%warunki pocztkowe
u=zeros(1,kk);
y=zeros(1,kk);
yzad=zeros(1,kk+D); yzad(1,start+25:kk+100)=1;

run('../zad_4/DMC_init.m');

for k=start:kk; %g��wna ptla symulacyjna
    %symulacja obiektu
    y(k) = -y((k-length(b)):(k-1))*(flip(b')) + u((k-length(c)+1):(k))*(flip(c'));  
    %wyznaczenie sterowania
    yo = y(k)*ones(D,1)+Mp*flip(deltaUp((k-D+1):(k-1))); % trajektoria swobodna
    deltau = K*(yzad(k:(k+D-1))'-yo); % wyznaczone przysz�e zmiany sterowania
    deltaUp(k) = deltau(1); % historia zmian sterowania
    %sygna� sterujcy regulatora DMC        
    u(k) = u(k-1)+deltau(1); % nowe sterowanie
end;
%wyniki symulacji

figure(1); 
subplot(2,1,1);
hold on; grid on; box on; 
plot((1:(kk-start+10+1))*Tp, u((start-10):kk));
title('Sygna� steruj�cy obiektem'); xlabel(''); ylabel('Warto��'); 
legend('Location', 'southeast');

subplot(2,1,2);
hold on; grid on; box on;
plot((1:kk-start+10+1)*Tp, y(start-10:kk)); 
title('Sygna� wyj�ciowy obiektu'); 
xlabel('Czas(s)'); ylabel('Warto��'); 
end;
stairs((1:kk-start+10+1)*Tp, yzad(start-10:kk)); 

% legendy do wykres�w do poszczeg�lnych podpunkt�w
run('legendsToA.m');
%run('legendsToB.m');
%run('legendsToC.m');
%run('legendsToD.m');

print(strcat('img/a/D_',num2str(D),'_lambda_',strrep(num2str(lambda),'.','_'),'_N_',num2str(N),'_Nu_',num2str(Nu)), '-dpng');
%close 1;