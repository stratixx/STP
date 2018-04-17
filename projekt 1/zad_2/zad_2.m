%run('../utils/init');
run('../zad_1/zad_1');
%beQuiet = false;
println('Start: Zad_2', beQuiet);
% Metoda 1
A1 = [ - den_z(2:end); 1 0 0; 0 1 0 ];
B1 = [ 1; 0; 0 ];
C1 = [ num_z(2:end) ];
D1 = [ 0 ];

% Metoda 2
A2 = [ - den_z(2:end); 1 0 0; 0 1 0 ]';
B2 = [ num_z(2:end)' ];
C2 = [ 1 0 0 ];
D2 = [ 0 ];

println('End: Zad_2', beQuiet);