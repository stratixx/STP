%run('../utils/init');
run('../zad_3/zad_3');
beQuiet = false;
println('Start: Zad_4', beQuiet);

% symulacja 3 ukladow, skok jednostkowy, zerowe warunki poczatkowe
x0 = [ 0 0 0 ];

% symulacja 3 ukladow, skok jednostkowy, niezerowe warunki poczatkowe
x0 = [ 1 1 1 ]; % wartosci do wyznaczenia

println('End: Zad_4', beQuiet);
beQuiet = true;