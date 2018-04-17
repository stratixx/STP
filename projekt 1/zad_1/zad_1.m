run('../utils/init');
load('../dane_poczatkowe');
%beQuiet = false;
println('Start: Zad_1', beQuiet);
% dyskretyzacja transmitancji
[num_z, den_z] = c2dm(num_s, den_s, Tp,'zoh');
% i mianownik transmitancji dyskretnej

zeros_s = roots(num_s)';
zeros_z = roots(num_z)';
poles_s = roots(den_s)';
poles_z = roots(den_z)';

println( strcat( 'Zera transmitancji ci퉓쿮j      : [', num2str( zeros_s), ']' ), beQuiet);
println( strcat( 'Bieguny transmitancji ci퉓쿮j   : [', num2str( poles_s), ']' ), beQuiet );
println( strcat( 'Zera transmitancji dyskretnej   : [', num2str( zeros_z), ']' ), beQuiet );
println( strcat( 'Bieguny transmitancji dyskretnej: [', num2str( poles_z), ']' ), beQuiet );

println('End: Zad_1', beQuiet);