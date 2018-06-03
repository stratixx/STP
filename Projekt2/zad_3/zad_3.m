load('../dane_poczatkowe.mat')

Kr = 0.38623;
Ti = 100000000;
Td = 0.000000001;

Kk = 0.38623
Tk = 20

Kr = 0.6*Kk
Ti = 0.5*Tk
Td = 0.12*Tk

s = tf('s');
Gs = K0*exp(-T0*s) / ( (T1*s+1)*(T2*s+1) );
if(1)
for kK=1:1:length(Kr)    
    PIDs = Kr(kK) * ( 1 + 1/(Ti*s) + Td*s );
    modelS = feedback( Gs*PIDs, 1 );
    figure(1)
    step(modelS)
    legend('PID', 'Location', 'southeast');
    xlabel('Czas');
    ylabel('Wartoœæ');
    title(strcat('Uk³ad regulacji z ci¹g³ym PID'));
    box on; grid on;  
    %print(strcat('img/wybrane/odp_skokowa_PID'),'-dpng');
    print(strcat('img/wybrane/Kr_', strrep(num2str(Kr(kK)),'.','_')),'-dpng');

    close 1;
end
end

r0 = Kr*(1+Tp/(2*Ti)+Td/Tp)
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1)
r2 = Kr*(1+Tp/(2*Ti)+Td/Tp)
