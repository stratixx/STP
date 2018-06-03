figure(1)
hold on; grid on; box on;
title('Obszary stabilno�ci algorytm�w PID i DMC')
xlabel('T_0/T_0_n_o_m');
ylabel('K_0/K_0_n_o_m');
plot(stabPID(2,:),stabPID(1,:),'.')
plot(stabDMC(2,:),stabDMC(1,:),'*')
legend('PID','DMC');
