function blad = ident3(X0) 
K  = X0(1); %pierwszy arg
T  = X0(2);
%theta  = X0(3); %tego nie optymalizujemy
t=0:59;
load obiekt

%---------------------------------------- ------%
% tutaj kod, który bêdzie oblicza³  %
% odpowiedŸ skokow¹ obiektu symulowanego %
% o takiej samej d³ugoœci jak odpowiedŸ  %
% obiektu rzeczywistego     %
for n=3:3
    o=zpk([],repmat(-1/T,1,n),K/T);%nie ma zer, biegun zawsze taski sam
    y_sym=step(o,t);
end
%---------------------------------------- ------%
%plot(t, y,t,y_sym);
e = y - y_sym;
blad = sum(e.^2) / length(e);