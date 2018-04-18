%run('../utils/init');
beQuiet = true;
run('../zad_3/zad_3');
beQuiet = false;
println('Start: Zad_4', beQuiet);

model_z = 'metoda_ogolna';
model_1 = '../zad_2/przestrzen_stanu_1';
model_2 = '../zad_2/przestrzen_stanu_2';
load_system(model_z);
load_system(model_1);
load_system(model_2);

cs = getActiveConfigSet(model_z);
model_cs = cs.copy;
set_param(model_cs,'Solver','ode45',...
                'StartTime','0', 'StopTime', '5', ...
                'SaveState','on', 'SaveOutput','on');

name = 'symulacja 3 ukladow, skok jednostkowy, zerowe warunki poczatkowe';
x0 = [ 0 0 0 ];
sim_model_z = sim(model_z, model_cs);
sim_model_1 = sim(model_1, model_cs);
sim_model_2 = sim(model_2, model_cs);
figure(1)
hold on;
box on;
grid on;
title(name);
plot(sim_model_z.get('tout'), sim_model_z.get('yout'));
plot(sim_model_1.get('tout'), sim_model_1.get('yout'));
plot(sim_model_2.get('tout'), sim_model_2.get('yout'));
print('img/zad_4_zero','-dpng');
hold off

name = 'symulacja 3 ukladow, skok jednostkowy, niezerowe warunki poczatkowe';
x0 = [ 10 1 10 ]; % wartosci do wyznaczenia
sim_model_z_nz = sim(model_z, model_cs);
sim_model_1_nz = sim(model_1, model_cs);
sim_model_2_nz = sim(model_2, model_cs);
figure(2)
hold on;
box on;
grid on;
title(name);
plot(sim_model_z_nz.get('tout'), sim_model_z_nz.get('yout'));
plot(sim_model_1_nz.get('tout'), sim_model_1_nz.get('yout'));
plot(sim_model_2_nz.get('tout'), sim_model_2_nz.get('yout'));
print('img/zad_4_non_zero','-dpng');
hold off;
close all;

println('End: Zad_4', beQuiet);