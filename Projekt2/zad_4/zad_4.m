load('../dane_poczatkowe.mat');

run('../zad_2/zad_2.m');

run('pid_init.m');

%inicjacja dmc
run('step_response.m');
D = length(s); % horyzont dynamiki
N=12;
Nu=1;
lambda = 6.9
run('DMC_init.m');

%inicjalizacja symulacji
regulator = 'PID';
start = 100;
kk=620; %koniec symulacji
%warunki pocztkowe
u=zeros(1,kk);
y=zeros(1,kk);
e=zeros(1,kk);
yzad=zeros(1,kk+100); yzad(1,start+25:kk+100)=1;

for k=start:kk; %g³ówna ptla symulacyjna
    %symulacja obiektu
    y(k) = -y((k-length(b)):(k-1))*(flip(b')) + u((k-length(c)+1):(k))*(flip(c'));  

    if regulator == 'PID'
        %uchyb regulacji
        e(k)=yzad(k)-y(k);
        %sygna³ sterujcy regulatora PID
        u(k)=r2*e(k-2)+r1*e(k-1)+r0*e(k)+u(k-1);
    end;
    
    if regulator == 'DMC' 
        yo = y(k)*ones(D,1)+Mp*flip(deltaUp((k-D+1):(k-1)));
        deltau = K*(yzad(k:(k+D-1))'-yo);
        deltaUp(k) = deltau(1);
        %sygna³ sterujcy regulatora DMC       
        u(k) = u(k-1)+deltau(1);
    end
end;
%wyniki symulacji
%uDMC=0; yDMC=0;
%uPID=0; yPID=0;
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
%print('img/wykres_y', '-dpng');