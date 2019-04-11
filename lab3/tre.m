%% 2.3  Wp�yw wzmocnienia na stabilno�� uk�adu
close all;
K1=30;
K2=250;

%%obiekt = zpk(-1/3,[0 -1 -3],3)
%%przy ka�dym s musi by� 1 �eby u�ywa� zpk - posta� sfaktoryzowana

%%conv - convolution- splot- wymno�enie
%%wielomian�w\%%m=conv(conv([1,2],[1,10]),[1,0]);o=tf(K,m)

o1=zpk([],[0 -2 -10], K1);
o2=zpk([],[0 -2 -10], K2);
figure;
subplot(1,2,1),nyquist(tf(o1));%po sprz�eniu b�dzie stabilny
subplot(1,2,2),nyquist(tf(o2));%po zwi�kszeniu wzmocnia nie, obiekt po prawej stronie-lini - niestabilny
%%1/s element ca�kuj�cy - wi�c tu obiekt inercyjno ca�kuj�cy- zaczyna si� w
%%niesko�czono�ci bo ca�kuj�cy

%% 2.4 Wp�yw dodawania do uk�adu biegun�w na jego stabilno��
close all;
K=10;
T1=0.1;
T2=0.5;
T3=0.8;

o1=zpk([],[-1/T1 -1/T2], K/(T1*T2));%wyci�gamy T przed nawias!!
o2=zpk([], [-1/T1 -1/T2 -1/T3], K/(T1*T2*T3));
figure;
%nyquist(tf(o1));hold on;nyquist(o2);
nyquist(o1, o2);
legend('2 bieguny', '3 bieguny');

%dodanie bieguna spowodowa�o przybli�enie do punku -1 - uk�ad ma
%mniejszy zapas stabailnosci bo jest bli�ej punktu krytycznego  - ��twiej
%wytr�ci� go z r�wnowagi,
%dodanie bieguna powoduje zmniejszenie zapasu stabilno�ci!

%% 2.5 Wp�yw dodawania do uk�adu zerowych biegun�w na jego stabilno��
l1=zpk([], -1, 1);%inercja I rz�du - nie da si� zniestabilizowa� - kalory, polewej stronie zgodnie ze strza�k�
l2=zpk([], [0 -1], 1);
l3=zpk([],[0 0 -1], 1);%niestabilny- po prawej stronie zgodnie ze strza�k�
l4=zpk([], [0 0 0 -1], 1);
subplot(2,2,1), nyquist(l1);%stabilny
subplot(2,2,2), nyquist(l2);%stabilny
subplot(2,2,3), nyquist(l3);%niestabilny - po prawej stronie zgodnie ze strza�k�
subplot(2,2,4), nyquist(l4);%niestabilny, im wy�szy rz�d tym trudniej graficznie zoobserwowa�
%dodawanie biegun�w zerowych prowadzi do destabilizacji

%% 2.6 Wp�yw dodawania do uk�adu zer na jego stabilno��
close all;
K=2;
T1=0.1;
T2=0.9;
Td=0.7;

l1=zpk([],[0 -1/T1 -1/T2],K/(T1*T2));
l2=zpk(-1/Td, [0 -1/T1 -1/T2], K*Td/(T1*T2));
figure;
%nyquistoptions.ShowFullContour = 'off';
nyquist(l1,l2);
 
legend('bez zer', 'z zerem');
%oba stabilne, dodanie zera - oddalenie od -1 - zwi�kszenie zapasu
%stabilno�ci - pozytywnie

%% 3.3 Obliczanie zapasu wzmocnienia i zapasu fazy dla uk�adu zamkni�tegoObliczanie zapasu wzmocnienia i zapasu fazy dla uk�adu zamkni�tego
close all;

[licz,mian] = zp2tf([],[-1 -1 -1],4);   %Zapisujemy licznik i mianownik transmitancji za pomoc� zer, biegun�w i wzmocnienia:
[Gm,Pm]=margin(licz,mian);  %Obliczamy zapas wzmocnienia Gm i zapas fazy Pm za pomoc� funkcji margin

%% 3.4. Obliczanie wzmocnienia uk�adu zamkni�tego dla zadanego zapasu wzmocnienia i zapasu fazy
faza=45;    %zadany zapas fazy
krok=0.01; %krok o kt�ry zwi�kszamy wzmocnienie
granica=8; %granica stabilno�ci, powy�ej kt�rej nie ma sensu szuka�
tolerancja=0.1; %dok�adno�� oblicze�
for K=1:krok:granica
[licz,mian]=zp2tf([],[-1 -1 -1],K); %w ka�dym kroku obliczamy nowa transmitancje
[Gm,Pm]=margin(licz,mian); %liczymy zapas modu�u Gm i fazy Pm
if abs(Pm-faza)<=tolerancja %sprawdzamy dopuszczalny b��d
fprintf(1,'Dla wzmocnienia K = %.3f zapas fazy wynosi %.3f stopnie\n',K,Pm)
fprintf(1,'Blad wynosi %f\n',abs(faza-Pm))
return
end
end
fprintf(1,'Nie znaleziono rozwiazania.\nZwieksz tolerancje lub/i zmniejsz krok\n')

%Zadanie 3.4.1.
[wynik,blad] = fminsearch('faza',1);
