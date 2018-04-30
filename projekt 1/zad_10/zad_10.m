load('../dane_po_zad_8.mat');

x0 = [-10 -20 -30];
x0_observer = [ 0 0 ]; % stan poczatkowy obserwatora

tkonc = 5;

K1 = [19.6282    4.3585    0.8528]; % wariant 1 regulatora
K2 = [19.6450    4.2382    0.1794]; % wariant 2 regulatora

Lslow=acker(A22',A12', [0.5 0.5])';
Lfast=acker(A22',A12', [0 0])';

kK = 1;
kL = 'fast';
%kL = 'slow';
K=K1;
L=Lfast;

%zaladowanie modelu symulowanego
model = 'reg_state_from_observer';
load_system(model);

cs = getActiveConfigSet(model);
model_cs = cs.copy;
set_param(model_cs,'Solver','ode45',...
                'StartTime','0', 'StopTime', num2str(tkonc), ...
                'SaveState','on', 'SaveOutput','on');

if true   
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
            ylabel('Wartoœæ');
            hold on; box on; grid on;
            title('Sygna³ steruj¹cy');
            stairs(t, u);
            legend('u(t)');
            subplot(2,1,2);
            xlabel('Czas');
            ylabel('Wartoœæ');
            hold on; box on; grid on;
            title('Zmienne stanu');
            stairs(t, x1);
            stairs(t, x2);
            stairs(t, x3);
            legend('x_1(t)', 'x_2(t)', 'x_3(t)');
            print(strcat('img/ogolne/zad_10_kK_', num2str(kK), '_kL_', kL,'_tkonc_',num2str(tkonc)),'-dpng');
            hold off;
            close all;
end
