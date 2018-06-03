load('../dane_poczatkowe.mat');

run('../zad_2/zad_2.m');

run('pid_init.m');

%inicjacja dmc
run('step_response.m');
D = length(s); % horyzont dynamiki
N=12;
Nu=1;
lambda = 1
run('DMC_init.m');

%inicjalizacja symulacji
regulator = 'DMC';
start = 100;
kk=229; %koniec symulacji
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

figure(1); 
subplot(2,1,1);
hold on; grid on; box on; 
stairs((1:kk-start+10+1)*Tp, uPID(start-10:kk)); 
stairs((1:kk-start+10+1)*Tp, uDMC(start-10:kk)); 
title('Wykres sterowania obiektu'); xlabel('Czas(s)'); ylabel('Wartoœæ'); 
legend('u_P_I_D', 'u_D_M_C');
subplot(2,1,2);
hold on; grid on; box on;
stairs((1:kk-start+10+1)*Tp, yPID(start-10:kk)); 
stairs((1:kk-start+10+1)*Tp, yDMC(start-10:kk)); 
stairs((1:kk-start+10+1)*Tp, yzad(start-10:kk)); 

title('Wykres wyjœcia obiektu'); 
xlabel('Czas(s)'); ylabel('Wartoœæ'); 
legend('y_P_I_D', 'y_D_M_C', 'y_z_a_d', 'location','southeast');

print('img/pid_with_dmc', '-dpng');
close 1;