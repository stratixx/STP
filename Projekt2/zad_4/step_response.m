start = 13;
kk=110; %koniec symulacji
%warunki pocztkowe
u=zeros(1,kk);
y=zeros(1,kk);
e=zeros(1,kk);
yzad=zeros(1,kk); yzad(1,start:kk)=1;

for k=start:kk; %g³ówna ptla symulacyjna
    %symulacja obiektu
    y(k) = -y((k-length(b)):(k-1))*(flip(b')) + yzad((k-length(c)+1):(k))*(flip(c'));
    %y(k) = -b(1)*y(k-1)-b(2)*y(k-2) + c(11+1)*u(k-11)+c(12+1)*u(k-12);  
end
%figure(2); hold on; plot(y);  legend('ynew')
begin = start;
stop = 55;
s = y(begin:stop);