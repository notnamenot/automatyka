%zapis transmitancji
M=1000;
F=1000;
a=500;
c=400;
licz=[0 0 1];%Aby zapisaæ t¹ transmitancjê w Matlabie nale¿y podaæ wspó³czynniki licznika i mianownika, zaczynaj¹c od najwy¿szej potêgi s:
mian=[M a c];%[1000 500 400]
figure
step(licz,mian);%odpowiedŸ skokowa
figure
impulse(licz,mian);%odpowiedŸ impulsowa
obiekt = tf(licz,mian);%transter function,obiekt jest struktur¹ przechowuj¹c¹ wszystkie informacje o obiekcie
get(obiekt); %Aby wyœwietliæ pola tej struktury
%step(obiekt);
%impulse(obiekt);
[z,p,k]=tf2zp(licz,mian); %W celu znalezienia zer (pierwiastków licznika transmitancji), 
                          %biegunów (pierwiastków mianownika transmitancji) oraz wzmocnienia uk³adu, 
                          %mo¿na zastosowaæ funkcjê tf2zp (ang. transfer function to zero-pole) konwersji transmitancji do reprezentacji zera/bieguny/wzmocnienie
    %Wektor z-zawiera zera uk³adu, wektor p – bieguny, k – wzmocnienie.
figure
pzmap(p,z);%v pzmap(licz,mian) v pzmap(obiekt) - Zera i bieguny mo¿na przedstawiæ graficznie na p³aszczyŸnie zespolonej

%% 1
ksi1=0.5;%przypadek oscylacyjny
ksi2=1.5;%t³umiony
K=1/c;
T=sqrt(M/c);
a1=ksi1*2*sqrt(c*M);
a2=ksi2*2*sqrt(c*M);
l=[0 0 K];
m1=[T*T 2*T*ksi1 1];
m2=[T*T 2*T*ksi2 1];
figure
step(l,m1)
title('przypadek oscylacyjny')
figure
step(l,m2)
title('przypadek t³umiony')

%% 3
z=-1/3;%zero(pierwiatek licznika)
p1=0;%biguny(pierwiastki mianownika)
p2=-1;
p3=-3;
p=[0 -1 -3];
k=3;%wzmocnienie(przemno¿enie licznika
[licz,mian]=zp2tf(z,p,k);%Licznik i mianownik transmitancji w postaci wielomianowej ³atwo jest znaleŸæ stosuj¹c funkcjê zp2tf konwersji reprezentacji zera/bieguny/wzmocnienie do transmitancji:
printsys(licz,mian);%Aby wyœwietliæ transmitancjê nale¿y
%obiekt = zpk(-1/3,[0 -1 -3],3);n

%% zad2
k=4;
z=-1/4;
p=[0 -5 -1/10];
obiekt=zpk(z,p,k);

%% 4 przestrzeñ stanów
[A,B,C,D]=zp2ss(z,p,k);% zero-pole to state space, Aby zamieniæ transmitancjê na reprezentacjê w przestrzeni stanów
[A1,B1,C1,D1]=tf2ss(licz,mian); % transfer function to state space
figure
step(A,B,C,D);%odpowiedŸ skokowa
figure
step(A1,B1,C1,D1);
impulse(A,B,C,D);
kk = dcgain(A,B,C,D);%Aby obliczyæ wzmocnienie w stanie ustalonym

%% 6
sys = series(sys1,sys2);%Dwa obiekty sys1 i sys2, po³¹czone szeregowo, mo¿na po³¹czyæ w jeden obiekt sys za pomoc¹ funkcji series
                        %Transmitancja obiektu sys jest nazywana transmitancj¹ zastêpcz¹ dla ca³ego uk³adu.
sys = parallel(sys1,sys2); %Dwa obiekty sys1 i sys2, po³¹czone równolegle, mo¿na po³¹czyæ w jeden obiekt sys za pomoc¹ funkcjiparallel

sys = feedback(sys1,sys2);%Dwa obiekty sys1 i sys2, po³¹czone za pomoc¹ ujemnego sprzê¿enia zwrotnego, mo¿na sprowadziæ do jednego obiektu sys za pomoc¹ funkcji feedback:

sys = feedback(sys1,sys2,+1);%W przypadku dodatniego sprzê¿enia zwrotnego

%% zad6
l1=[0 1 1];
m1=[1 5 1];
o1=tf(l1,m1);

l2=[0 0 0 1];
m2=[1 1 -2 1];
o2=tf(l2,m2);

sys1=series(o1,o2);%szeregowo
sys2=parallel(o1,o2);%równolegle
sys3=feedback(o1,o2);%sprze¿enie zwrotne