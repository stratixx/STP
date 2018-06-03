% generator wykresu do zad 6
figure(1)
hold on; grid on; box on;
title('Obszary stabilnoœci algorytmów PID i DMC')
xlabel('T_0/T_0_n_o_m');
ylabel('K_0/K_0_n_o_m');
plot(stabPID(2,:),stabPID(1,:),'-o')
plot(stabDMC(2,:),stabDMC(1,:),'-o')
legend('PID','DMC');
print('img/obszaryStabilnosci', '-dpng')
close 1;