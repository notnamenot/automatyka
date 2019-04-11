%zapis transmitancji
M=1000;
F=1000;
a=500;
c=400;
licz=[0 0 1];%Aby zapisa� t� transmitancj� w Matlabie nale�y poda� wsp�czynniki licznika i mianownika, zaczynaj�c od najwy�szej pot�gi s:
mian=[M a c];%[1000 500 400]
figure
step(licz,mian);%odpowied� skokowa
figure
impulse(licz,mian);%odpowied� impulsowa
obiekt = tf(licz,mian);%transter function,obiekt jest struktur� przechowuj�c� wszystkie informacje o obiekcie
get(obiekt); %Aby wy�wietli� pola tej struktury
%step(obiekt);
%impulse(obiekt);
[z,p,k]=tf2zp(licz,mian); %W celu znalezienia zer (pierwiastk�w licznika transmitancji), 
                          %biegun�w (pierwiastk�w mianownika transmitancji) oraz wzmocnienia uk�adu, 
                          %mo�na zastosowa� funkcj� tf2zp (ang. transfer function to zero-pole) konwersji transmitancji do reprezentacji zera/bieguny/wzmocnienie
    %Wektor z-zawiera zera uk�adu, wektor p � bieguny, k � wzmocnienie.
figure
pzmap(p,z);%v pzmap(licz,mian) v pzmap(obiekt) - Zera i bieguny mo�na przedstawi� graficznie na p�aszczy�nie zespolonej

%% 1
ksi1=0.5;%przypadek oscylacyjny
ksi2=1.5;%t�umiony
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
title('przypadek t�umiony')

%% 3
z=-1/3;%zero(pierwiatek licznika)
p1=0;%biguny(pierwiastki mianownika)
p2=-1;
p3=-3;
p=[0 -1 -3];
k=3;%wzmocnienie(przemno�enie licznika
[licz,mian]=zp2tf(z,p,k);%Licznik i mianownik transmitancji w postaci wielomianowej �atwo jest znale�� stosuj�c funkcj� zp2tf konwersji reprezentacji zera/bieguny/wzmocnienie do transmitancji:
printsys(licz,mian);%Aby wy�wietli� transmitancj� nale�y
%obiekt = zpk(-1/3,[0 -1 -3],3);n

%% zad2
k=4;
z=-1/4;
p=[0 -5 -1/10];
obiekt=zpk(z,p,k);

%% 4 przestrze� stan�w
[A,B,C,D]=zp2ss(z,p,k);% zero-pole to state space, Aby zamieni� transmitancj� na reprezentacj� w przestrzeni stan�w
[A1,B1,C1,D1]=tf2ss(licz,mian); % transfer function to state space
figure
step(A,B,C,D);%odpowied� skokowa
figure
step(A1,B1,C1,D1);
impulse(A,B,C,D);
kk = dcgain(A,B,C,D);%Aby obliczy� wzmocnienie w stanie ustalonym

%% 6
sys = series(sys1,sys2);%Dwa obiekty sys1 i sys2, po��czone szeregowo, mo�na po��czy� w jeden obiekt sys za pomoc� funkcji series
                        %Transmitancja obiektu sys jest nazywana transmitancj� zast�pcz� dla ca�ego uk�adu.
sys = parallel(sys1,sys2); %Dwa obiekty sys1 i sys2, po��czone r�wnolegle, mo�na po��czy� w jeden obiekt sys za pomoc� funkcjiparallel

sys = feedback(sys1,sys2);%Dwa obiekty sys1 i sys2, po��czone za pomoc� ujemnego sprz�enia zwrotnego, mo�na sprowadzi� do jednego obiektu sys za pomoc� funkcji feedback:

sys = feedback(sys1,sys2,+1);%W przypadku dodatniego sprz�enia zwrotnego

%% zad6
l1=[0 1 1];
m1=[1 5 1];
o1=tf(l1,m1);

l2=[0 0 0 1];
m2=[1 1 -2 1];
o2=tf(l2,m2);

sys1=series(o1,o2);%szeregowo
sys2=parallel(o1,o2);%r�wnolegle
sys3=feedback(o1,o2);%sprze�enie zwrotne