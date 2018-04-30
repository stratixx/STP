load('../dane_po_zad_4.mat');

x0 = [ -1; -2; -3 ];
tkonc = 5;

%zaladowanie modelu symulowanego
model = 'reg_od_stanu';
load_system(model);

cs = getActiveConfigSet(model);
model_cs = cs.copy;
set_param(model_cs,'Solver','ode45',...
                'StartTime','0', 'StopTime', num2str(tkonc), ...
                'SaveState','on', 'SaveOutput','on');

if false   
% Wariant 1 - trzy bieguny rzeczywiste
zb = 0.1;
for k=1:1:length(zb)
    z_var_1 = [zb(k) zb(k) zb(k)];
    K = acker(A2, B2, z_var_1);
    N = [A2 B2;C2 D2]^(-1)*[0;0;0;1];
    K1 = K;
    sim_model = sim(model, model_cs);
    x = sim_model.get('xout');
    y = sim_model.get('yout');
    t = sim_model.get('tout');
    if max(y(:,1))>10^6 || max(x(:,1))>10^3 || max(x(:,2))>10^3 || max(x(:,3))>10^3
        continue;
    end
    display(zb(k))
    figure(1)
    subplot(2,1,1);
    xlabel('Czas');
    ylabel('Wartoœæ');
    hold on; box on; grid on;
    title('Sygna³ steruj¹cy');
    stairs(t, y(:,1));
    legend('u(t)');
    subplot(2,1,2);
    xlabel('Czas');
    ylabel('Wartoœæ');
    hold on; box on; grid on;
    title('Zmienne stanu');
    stairs(t, x(:,3));
    stairs(t, x(:,2));
    stairs(t, x(:,1));
    legend('x_1(t)', 'x_2(t)', 'x_3(t)');
    print(strcat('img/wariant1/zad_6_wariant_1_zb_', strrep(num2str(zb(k)),'.','_'),'_tkonc_',num2str(tkonc)),'-dpng');
    hold off;
    close all;
end
    z0 = z_var_1;
end

if true
% Wariant 2 - Bieguny zespolone
    z1 = 0.1;
    a=0.1;
    b=0.2;
    poles = zeros(length(a-1)*length(b-1),3);
    for na=1:1:length(a)
        %display('a = '); display(num2str(a(na)));
        for nb=1:1:length(b)
        z2 = a(na) + b(nb)*j;
        z3 = a(na) - b(nb)*j;
        z_var_2 = [z1 z2 z3];
        K = place(A2, B2, z_var_2);
        N = [A2 B2;C2 D2]^(-1)*[0;0;0;1];
        K2 = K;
        sim_model = sim(model, model_cs);
        x = sim_model.get('xout');
        y = sim_model.get('yout');
        t = sim_model.get('tout');
        %display(strcat(' Amplitude: ',num2str(mean(max(x)-min(x)))))
        if max(y(:,1))>10^5 || max(x(:,1))>10^4 || max(x(:,2))>10^4 || max(x(:,3))>10^4
            continue;
        end
        %display(a(na));
        %display(b(nb))
        figure(1)
        subplot(2,1,1);
        xlabel('Czas');
        ylabel('Wartoœæ');
        hold on; box on; grid on;
        title('Sygna³ steruj¹cy');
        stairs(t, y(:,1));
        legend('u(t)');
        subplot(2,1,2);
        xlabel('Czas');
        ylabel('Wartoœæ');
        hold on; box on; grid on;
        title('Zmienne stanu');
        stairs(t, x(:,3));
        stairs(t, x(:,2));
        stairs(t, x(:,1));
        legend('x_1(t)', 'x_2(t)', 'x_3(t)');
        print(strcat('img/wariant2/zad_6_wariant_2_a_', strrep(num2str(a(na)),'.','_'),'_b_', strrep(num2str(b(nb)),'.','_')),'-dpng');
        hold off;
        close all;
        end
    end
    z0 = z_var_2;
end

clear tkonc z_var_1 z_var_2 cs model_cs
clear a b k model na nb poles sim_model t x y z0 z1 z2 z3 zb