function blad = ident2(X0) 
K  = X0(1); %pierwszy arg
T1  = X0(2);
T2  = X0(3);
theta  = X0(4);
t=0:59;
load obiekt

%---------------------------------------- ------%
% tutaj kod, który bêdzie oblicza³  %
% odpowiedŸ skokow¹ obiektu symulowanego %
% o takiej samej d³ugoœci jak odpowiedŸ  %
% obiektu rzeczywistego     %
o=tf(K,[T1*T2 T1+T2 1], 'OutputDelay', theta);
y_sym=step(o,t);

%---------------------------------------- ------% 
e = y - y_sym;
blad = sum(e.^2) / length(e);