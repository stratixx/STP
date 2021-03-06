%run('../utils/init');
beQuiet = true;
run('../zad_3/zad_3');
%beQuiet = false;

tkonc = 5;

println('Start: Zad_4', beQuiet);

model_z = 'metoda_ogolna';
model_1 = 'przestrzen_stanu_1';
model_2 = 'przestrzen_stanu_2';
load_system(model_z);
load_system(model_1);
load_system(model_2);

cs = getActiveConfigSet(model_z);
model_cs = cs.copy;
set_param(model_cs,'Solver','FixedStepDiscrete',...
                'StartTime','0', 'StopTime', num2str(tkonc), ...
                'SaveState','on', 'SaveOutput','on');

name = 'Odpowied� skokowa modeli, zerowe warunki poczatkowe';
x0 = [ 0 0 0 ];
sim_model_z = sim(model_z, model_cs);
sim_model_1 = sim(model_1, model_cs);
sim_model_2 = sim(model_2, model_cs);
figure(1)
hold on; box on; grid on;
title(name);
stairs(sim_model_z.get('tout'), sim_model_z.get('yout'));
stairs(sim_model_1.get('tout'), sim_model_1.get('yout'));
legend('Transmitancja dyskretna', 'Model wariant 1');
print('img/1_z_zero','-dpng');
figure(2)
hold on; box on; grid on;
title(name);
stairs(sim_model_z.get('tout'), sim_model_z.get('yout'));
stairs(sim_model_2.get('tout'), sim_model_2.get('yout'));
legend('Transmitancja dyskretna', 'Model wariant 2');
print('img/2_z_zero','-dpng');
hold off

name = 'Odpowied� skokowa modeli, niezerowe warunki poczatkowe';
x0 = [ 1 1 1 ]; % wartosci do wyznaczenia
sim_model_z = sim(model_z, model_cs);
sim_model_1 = sim(model_1, model_cs);
sim_model_2 = sim(model_2, model_cs);
figure(3)
hold on; box on; grid on;
title(name);
stairs(sim_model_z.get('tout'), sim_model_z.get('yout'));
stairs(sim_model_1.get('tout'), sim_model_1.get('yout'));
legend('Transmitancja dyskretna', 'Model wariant 1');
print('img/test/1_z_non_zero','-dpng');
figure(4)
hold on; box on; grid on;
title(name);
stairs(sim_model_z.get('tout'), sim_model_z.get('yout'));
stairs(sim_model_2.get('tout'), sim_model_2.get('yout'));
legend('Transmitancja dyskretna', 'Model wariant 2');
print('img/test/2_z_non_zero','-dpng');
hold off
close all;

println('End: Zad_4', beQuiet);

clear A A1 B B1 C C1 D D1 cs model_1 model_2 model_cs model_z name
clear num_s den_s poles_s poles_z zeros_s zeros_z x0 tkonc
clear sim_model_1 sim_model_1_nz sim_model_2 sim_model_2_nz sim_model_z sim_model_z_nz