%<- inercji pierwszwgo rzêdu nie da siê zdestabilizowaæ
load obiekt

%zak³ócenia, b³êdy, szumy, -realny obiekt
%np szybkie w³¹czenie kaloryfera i tego przebieg temperatury

%A  obiekt inercyjny I rzêdu z opóŸnieniem
t=0:59;
K=2.102;
theta=7.2112;
T=14.555;

%n=5;
%[licz_op, mian_op] = pade(theta, n);
%licz_iner = [0,K]; mian_iner = [T,1];
%[licz, mian] = series(licz_op, mian_op, licz_iner, mian_iner);

o=tf(K,[T 1], 'OutputDelay', theta);%z opóŸnieniem
y_model=step(o,t);
plot(t, y,t,y_model);

%b³¹d œredniokwasratowy
e=y-y_model;%minsquareerror
MSE=sum(e.^2)/length(e);

%%2.4. Optymalizacja numeryczna
%fminsearch funkcja do optymalizacji - wyjœciem ma byæ b³¹d

%n to dla nas theta bo pierwszy model
[parametry, blad] = fminsearch('ident',[K,T,theta])
%% B
T1=12;
T2=6;

[parametry, blad] = fminsearch('ident2',[K,T1,T2,theta])
%najlepszy wynik
%% C
%nie ma opó¿nienia a model C przecie¿ nie ma opó¿nienia
%ale
%n musi byæ liczb¹ naturaln¹, nie optymalizujemy n tylko robimy pêtlê
%sprawdzamy od 3 do powiedzmy 5,przebieg szybko robi siê stromy

%n=3 nalepszy im wiecej tym gorzej
[parametry, blad] = fminsearch('ident3',[K,T])