%run('../utils/init');
beQuiet = true;
run('../zad_3/zad_3');
beQuiet = false;
println('Start: Zad_4', beQuiet);

% symulacja 3 ukladow, skok jednostkowy, zerowe warunki poczatkowe
x0 = [ 0 0 0 ];

%simOut = sim('../zad_2/przestrzen_stanu_1.slx')
%output = simOut.get('Y(z)')
% symulacja 3 ukladow, skok jednostkowy, niezerowe warunki poczatkowe
%x0 = [ 1 1 1 ]; % wartosci do wyznaczenia

println('End: Zad_4', beQuiet);