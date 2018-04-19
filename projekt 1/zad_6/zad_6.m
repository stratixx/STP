load('../dane_2_etap.mat');

x0 = [ -1; -2; -3 ];
xt = [ 0; 0; 0; ];
tkonc = 10;

K = sym('K', [1,length(B2)]);
syms z;

r_char = det(z*eye(length(B2)) - (A2-B2*K));
% wspolczynniki stojace przy z^n
r = [   1, 
        (672557354893199*K(1))/2251799813685248 - (2950889731229253*K(2))/9007199254740992 + (4752430356442243*K(3))/72057594037927936 - (1348489839080597)/281474976710656,
        (3172446340490269)/2251799813685248 - (2950889731229253*K(1))/9007199254740992 + (6159260074293747474488255087903*K(2))/5070602400912917605986812821504 - (46160883997977223069243831398579*K(3))/162259276829213363391578010288128,
        (4752430356442243*K(1))/72057594037927936 - (46160883997977223069243831398579*K(2))/162259276829213363391578010288128 + (37895860947843639396416525838085*K(3))/649037107316853453566312041152512 - 7594814535391211/72057594037927936
]';

%zaladowanie modelu symulowanego
model = 'reg_od_stanu';
load_system(model);

cs = getActiveConfigSet(model);
model_cs = cs.copy;
set_param(model_cs,'Solver','ode45',...
                'StartTime','0', 'StopTime', num2str(tkonc), ...
                'SaveState','on', 'SaveOutput','on');

if true            
zb = 0.6;
for k=1:1:length(zb)
    name = strcat('Wariant 1, trzy bieguny rzeczywiste zb=',num2str(zb(k)));
    K = acker(A2, B2, [zb(k) zb(k) zb(k)]);
    sim_model = sim(model, model_cs);
    x= sim_model.get('xout');
    y = sim_model.get('yout');
    t = sim_model.get('tout');
    
    figure(1)
    subplot(2,1,1);
    xlabel('Czas');
    ylabel('Wartoœæ');
    hold on; box on; grid on;
    title('Sygna³ steruj¹cy');
    plot(t, y);
    legend('u(t)');
    subplot(2,1,2);
    xlabel('Czas');
    ylabel('Wartoœæ');
    hold on; box on; grid on;
    title('Zmienne stanu');
    plot(t, x(:,3));
    plot(t, x(:,2));
    plot(t, x(:,1));
    legend('x1(t)', 'x2(t)', 'x3(t)');
    print(strcat('img/wariant1/ogolne/zad_6_wariant_1_zb_', strrep(num2str(zb(k)),'.','_'),'_tkonc_',num2str(tkonc)),'-dpng');
    hold off;
    close 1;
end
end

if true
    name = 'Bieguny zespolone, ';
    a=0.25;
    b=0.02;
    poles = zeros(length(a-1)*length(b-1),3);
    for na=1:1:length(a)
        for nb=1:1:length(b)
        z1 = 0.15;
        z2 = a(na) + b(nb)*j;
        z3 = a(na) - b(nb)*j;
        K = place(A2, B2, [z1 z2 z3]);
        sim_model = sim(model, model_cs);
        x= sim_model.get('xout');
        y = sim_model.get('yout');
        t = sim_model.get('tout');
        if max(y)>10^3 || max(x(:,1))>10^3 ||max(x(:,2))>10^3 ||max(x(:,3))>10^3
            continue;
        end
        figure(1)
        subplot(2,1,1);
        xlabel('Czas');
        ylabel('Wartoœæ');
        hold on; box on; grid on;
        title('Sygna³ steruj¹cy');
        plot(t, y);
        legend('u(t)');
        subplot(2,1,2);
        xlabel('Czas');
        ylabel('Wartoœæ');
        hold on; box on; grid on;
        title('Zmienne stanu');
        plot(t, x(:,3));
        plot(t, x(:,2));
        plot(t, x(:,1));
        legend('x1(t)', 'x2(t)', 'x3(t)');
        print(strcat('img/wariant2/ogolne/zad_6_wariant_2_a_', strrep(num2str(a(na)),'.','_'),'_b_', strrep(num2str(b(nb)),'.','_')),'-dpng');
        hold off;
        close 1;
        end
    end
end