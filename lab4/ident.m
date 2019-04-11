function blad = ident(X0) 

K  = X0(1); %pierwszy arg
T  = X0(2);
theta  = X0(3);
t=0:59;
load obiekt

%---------------------------------------- ------%
% tutaj kod, który bêdzie oblicza³  %
% odpowiedŸ skokow¹ obiektu symulowanego %
% o takiej samej d³ugoœci jak odpowiedŸ  %
% obiektu rzeczywistego     %
o=tf(K,[T 1], 'OutputDelay', theta);
y_sym=step(o,t);

%---------------------------------------- ------% 
e = y - y_sym;
blad = sum(e.^2) / length(e);

