load('../dane_po_zad_4.mat')
% Sterowalnoœæ
S = [ B2 A2*B2 A2^2*B2 ];
detS = det(S);
if abs(detS)>(10^(-4))
    println(strcat('Model jest sterowalny, det(S) = ',num2str(detS)));
else
    println(strcat('Model jest sterowalny, det(S) = ',num2str(detS)));
end
% Obserwowalnoœæ
O = [ C2; C2*A2; C2*A2^2 ];
detO = det(O);
if abs(detO)>(10^(-4))
    println(strcat('Model jest obserwowalny, det(O) = ',num2str(detO)));
else
    println(strcat('Model nie jest obserwowalny, det(O) = ',num2str(detO)));
end