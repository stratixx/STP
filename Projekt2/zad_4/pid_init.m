
% parametry PID
Kk = 0.38623;
Tk = 20;

Kr = 0.6*Kk;
Ti = 0.5*Tk;
Td = 0.12*Tk;

r0 = Kr*(1+Tp/(2*Ti)+Td/Tp);
r1 = Kr*(Tp/(2*Ti)-2*Td/Tp-1);
r2 = Kr*Td/Tp;