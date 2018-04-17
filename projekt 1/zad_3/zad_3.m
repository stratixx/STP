%run('../utils/init');
run('../zad_2/zad_2');
%beQuiet = false;
println('Start: Zad_3', beQuiet);

transmit_1 = tf(d2c(ss(A1,B1,C1,D1, Tp)));
transmit_2 = tf(d2c(ss(A2,B2,C2,D2, Tp)));
if ~beQuiet
    display(transmit_1);
    display(transmit_2);
end
println('End: Zad_3', beQuiet);

%beQuiet = true;