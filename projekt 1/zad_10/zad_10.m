load('../dane_po_zad_8.mat');

x0 = [-1 -2 -3];
x0_observer = [ 0 0 ]; % stan poczatkowy obserwatora

A22 = A2(2:3,2:3);
A12 = A2(1,2:3);
A11 = A2(1,1);
A21 = A2(2:3,1);
B_1 = B2(1,1);
B_2 = B2(2:3,1);

tkonc = 2;

%zaladowanie modelu symulowanego
model = 'reg_state_from_observer';
load_system(model);

cs = getActiveConfigSet(model);
model_cs = cs.copy;
set_param(model_cs,'Solver','ode45',...
                'StartTime','0', 'StopTime', num2str(tkonc), ...
                'SaveState','on', 'SaveOutput','on');

if true   
    
    for kK=1:1:length(K(:,1))
        for kL=1:1:length(L(1,:))
            sim_model = sim(model, model_cs);
            y = sim_model.get('yout');
            x = sim_model.get('xout');
            t = sim_model.get('tout');
            if  max(max(x))>10^3
                %display('niestabilny')
                continue;
            end
            
                %continue;
            x1 = x(:,1);
            x2 = x(:,2);
            x3 = x(:,3);
            u  = y(:,2);
            
            figure(1)
            subplot(2,1,1);
            xlabel('Czas');
            ylabel('Warto��');
            hold on; box on; grid on;
            title('Sygna� steruj�cy');
            plot(t, u);
            legend('u(t)');
            subplot(2,1,2);
            xlabel('Czas');
            ylabel('Warto��');
            hold on; box on; grid on;
            title('Zmienne stanu');
            plot(t, x1);
            plot(t, x2);
            plot(t, x3);
            legend('x_1(t)', 'x_2(t)', 'x_3(t)');
            print(strcat('img/ogolne/zad_10_kK_', num2str(kK), '_kL_', num2str(kL),'_tkonc_',num2str(tkonc)),'-dpng');
            hold off;
            close all;
        end
    end
end
