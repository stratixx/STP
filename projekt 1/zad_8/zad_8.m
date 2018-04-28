load('../dane_po_zad_6.mat');

tkonc = 5;

x0 = [-1 -2 -3];
x0_observer = [ 0 0 ]; % stan poczatkowy obserwatora

K1 = [19.6282    4.3585    0.8528]; % wariant 1 regulatora
K2 = [19.2252    4.2790    0.7666]; % wariant 2 regulatora

K = K1;

A22 = A2(2:3,2:3);
A12 = A2(1,2:3);
A11 = A2(1,1);
A21 = A2(2:3,1);
B_1 = B2(1,1);
B_2 = B2(2:3,1);


Lslow=acker(A22',A12', [0.5 0.5])';
Lfast=acker(A22',A12', [0 0])';

%zaladowanie modelu symulowanego
model = 'observer_test';
load_system(model);

cs = getActiveConfigSet(model);
model_cs = cs.copy;
set_param(model_cs,'Solver','ode45',...
                'StartTime','0', 'StopTime', num2str(tkonc), ...
                'SaveState','on', 'SaveOutput','on');

if true   
    z2 = [0 0.5];
    z3 = [0 0.5];
    for kz2=1:1:length(z2)
        display('z2 = '); display(num2str(z2(kz2)));
        for kz3=1:1:length(z3)
            z0_observer = [z2(kz2) z3(kz3)];
            L=acker(A22',A12', z0_observer)';
            break;
            sim_model = sim(model, model_cs);
            x = sim_model.get('xout');
            t = sim_model.get('tout');
            if  max(max(x))>10^5
                %display('niestabilny')
                continue;
            end
            
            x2_reg = x(:,3);
            x2_obs = x(:,4);
            x3_reg = x(:,2);
            x3_obs = x(:,5);
            
            display(z2(kz2));
            display(z3(kz3));
            figure(1)
            subplot(2,1,1);
            xlabel('Czas');
            ylabel('Wartoœæ');
            hold on; box on; grid on;
            title('Zmienna stanu x2');
            stairs(t, x2_reg);
            stairs(t, x2_obs);
            legend('x_2reg(t)', 'x_2obs(t)', 'Location', 'southeast');
            subplot(2,1,2);
            xlabel('Czas');
            ylabel('Wartoœæ');
            hold on; box on; grid on;
            title('Zmienna stanu x3');
            stairs(t, x3_reg);
            stairs(t, x3_obs);
            legend('x_3reg(t)', 'x_3obs(t)', 'Location', 'southeast');
            print(strcat('img/zad_8_z2_', strrep(num2str(z2(kz2)),'.','_'), '_z3_', strrep(num2str(z3(kz3)),'.','_'),'_tkonc_',num2str(tkonc)),'-dpng');
            hold off;
            close all;
        end
    end
end

clear cs K L kz2 kz3 model model_cs sim_model t tkonc x z0_observer z2 z3
clear x2_obs x2_reg x3_obs x3_reg x0 x0_observer
