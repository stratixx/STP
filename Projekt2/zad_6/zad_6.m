load('../dane_poczatkowe.mat');
run('../zad_2/zad_2.m');

run('../zad_4/pid_init.m');

%inicjacja dmc
run('../zad_4/step_response.m');
D = length(s); % horyzont dynamiki
N=12;
Nu=1;
lambda = 6.9;
run('../zad_4/DMC_init.m');

regulator = 'PID';
startT0 = T0;
startK0 = K0;
wspT0 = 1:0.1:2;

stab = zeros(2,length(wspT0));

for kT0=1:1:length(wspT0)
    T0 = startT0 * wspT0(kT0);
    K0 = startK0;
    while K0<100
        K0 = K0 + 0.1;
        % przeliczenie parametrów obiektu
        run('../zad_2/zad_2.m');

        %inicjalizacja symulacji
        start = 100;
        kk=5620; %koniec symulacji
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
        if max(abs(y))>3
            display(strcat('niestabliny dla T0=',num2str(T0),' K0=',num2str(K0)))
            stab(:,kT0) = [ (K0-0.1)/startK0; T0/startT0 ]
            break
        end
    end
end
%wyniki symulacji
%uDMC=0; yDMC=0; stabDMC=0;
%uPID=0; yPID=0; stabPID=0;
if regulator == 'DMC'
    uDMC = u; yDMC = y;
    stabDMC = stab
end
if regulator == 'PID'
    uPID = u; yPID = y;
    stabPID = stab
end
