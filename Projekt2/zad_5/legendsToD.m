subplot(2,1,1);
legend(...
    strcat('u_D_M_C|{\lambda}=',num2str(lambdavect(1))),...
    strcat('u_D_M_C|{\lambda}=',num2str(lambdavect(2))),...
    strcat('u_D_M_C|{\lambda}=',num2str(lambdavect(3))),...
    strcat('u_D_M_C|{\lambda}=',num2str(lambdavect(4))),...
    strcat('u_D_M_C|{\lambda}=',num2str(lambdavect(5))),...
    'Location', 'southeast');
subplot(2,1,2);
legend(...
    strcat('y_m_o_d|{\lambda}=',num2str(lambdavect(1))),...
    strcat('y_m_o_d|{\lambda}=',num2str(lambdavect(2))),...
    strcat('y_m_o_d|{\lambda}=',num2str(lambdavect(3))),...
    strcat('y_m_o_d|{\lambda}=',num2str(lambdavect(4))),...
    strcat('y_m_o_d|{\lambda}=',num2str(lambdavect(5))),...
    strcat('y_z_a_d'),...
    'Location', 'southeast');