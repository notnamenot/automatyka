%<- inercji pierwszwgo rz�du nie da si� zdestabilizowa�
load obiekt

%zak��cenia, b��dy, szumy, -realny obiekt
%np szybkie w��czenie kaloryfera i tego przebieg temperatury

%A  obiekt inercyjny I rz�du z op�nieniem
t=0:59;
K=2.102;
theta=7.2112;
T=14.555;

%n=5;
%[licz_op, mian_op] = pade(theta, n);
%licz_iner = [0,K]; mian_iner = [T,1];
%[licz, mian] = series(licz_op, mian_op, licz_iner, mian_iner);

o=tf(K,[T 1], 'OutputDelay', theta);%z op�nieniem
y_model=step(o,t);
plot(t, y,t,y_model);

%b��d �redniokwasratowy
e=y-y_model;%minsquareerror
MSE=sum(e.^2)/length(e);

%%2.4. Optymalizacja numeryczna
%fminsearch funkcja do optymalizacji - wyj�ciem ma by� b��d

%n to dla nas theta bo pierwszy model
[parametry, blad] = fminsearch('ident',[K,T,theta])
%% B
T1=12;
T2=6;

[parametry, blad] = fminsearch('ident2',[K,T1,T2,theta])
%najlepszy wynik
%% C
%nie ma op�nienia a model C przecie� nie ma op�nienia
%ale
%n musi by� liczb� naturaln�, nie optymalizujemy n tylko robimy p�tl�
%sprawdzamy od 3 do powiedzmy 5,przebieg szybko robi si� stromy

%n=3 nalepszy im wiecej tym gorzej
[parametry, blad] = fminsearch('ident3',[K,T])