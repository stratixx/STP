load('../dane_po_zad_6.mat');

x0 = [-1 -2 -3];
x0_observer = [ 0 0 ]; % stan poczatkowy obserwatora

A22 = A2(2:3,2:3);
A12 = A2(1,2:3);
A11 = A2(1,1);
A21 = A2(2:3,1);
B_1 = B2(1,1);
B_2 = B2(2:3,1);

tkonc = 1;

%zaladowanie modelu symulowanego
model = 'observer_test';
load_system(model);

cs = getActiveConfigSet(model);
model_cs = cs.copy;
set_param(model_cs,'Solver','ode45',...
                'StartTime','0', 'StopTime', num2str(tkonc), ...
                'SaveState','on', 'SaveOutput','on');

if true   
    z2 = 0;
    z3 = 0;
    for kz2=1:1:length(z2)
        for kz3=1:1:length(z3)
            L=acker(A22',A12', [z2(kz2) z3(kz3)])';
            sim_model = sim(model, model_cs);
            x = sim_model.get('xout');
            t = sim_model.get('tout');
            if  max(max(x))>10^3
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
            plot(t, x2_reg);
            plot(t, x2_obs);
            legend('x_2reg(t)', 'x_2obs(t)', 'Location', 'southeast');
            subplot(2,1,2);
            xlabel('Czas');
            ylabel('Wartoœæ');
            hold on; box on; grid on;
            title('Zmienna stanu x3');
            plot(t, x3_reg);
            plot(t, x3_obs);
            legend('x_3reg(t)', 'x_3obs(t)', 'Location', 'southeast');
            print(strcat('img/ogolne/zad_9_z2_', strrep(num2str(z2(kz2)),'.','_'), '_z3_', strrep(num2str(z2(kz2)),'.','_'),'_tkonc_',num2str(tkonc)),'-dpng');
            hold off;
            close all;
        end
    end
end
