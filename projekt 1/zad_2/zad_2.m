%run('../utils/init');
beQuiet = true;
run('../zad_1/zad_1');
%beQuiet = false;
println('Start: Zad_2', beQuiet);

% Przekszta³cenie transmitancji G(z) do postaci macierzy A,B,C,D
trans_z = ss(tf(num_z,den_z,Tp));
A = trans_z.a;
B = trans_z.b;
C = trans_z.c;
D = trans_z.d;
clear trans_z;

% Metoda 1
A1 = [ - den_z(2:end); 1 0 0; 0 1 0 ];
B1 = [ 1; 0; 0 ];
C1 = [ num_z(2:end) ];
D1 = [ 0 ];

% Metoda 2
A2 = A1';
B2 = C1';A
C2 = B1';
D2 = [ 0 ];


println('End: Zad_2', beQuiet);