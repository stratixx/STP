% Sterowalność
S = [ B2 A2*B2 A2^2*B2 ];
detS = det(S);

% Obserwowalność
O = [ C2; C2*A2; C2*A2^2 ];
detO = det(O);