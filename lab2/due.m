%charakterystyki czasowe-odpowiedzi obiektu na okreœlone wymuszenie w dziedzinie czasu
%Do wyznaczania charakterystyk czasowych nale¿y wykorzystaæ nastêpuj¹ce funkcje:
    %step(licz, mian); charakterystyka skokowa
    %impulse(licz, mian); charakterystyka impulsowa
%Je¿eli funkcje te nie zawieraj¹ argumentów wyjœciowych (tak jak powy¿ej) to automatycznie generowany jest wykres odpowiedniej charakterystyki. 
%Je¿eli maj¹ one argumenty wyjœciowe postaci:
    %[y,x,czas] = step(licz, mian);
    %[y,x,czas] = impulse(licz, mian);
%to wtedy otrzymuje siê wektory zawieraj¹ce sk³adowe odpowiedniej.
%Wykresy s¹ generowane automatycznie (patrz punkt 2) lub mo¿na je narysowaæ za pomoc¹instrukcji plot, np.:
    %plot(czas,y) v plot(czas1,y1,czas2,y2)
%% B
%wykres Bodego - zmiana amplitudy i fazy


%% 
close all;
k=1;
T=1;
T1=1;
T2=1;
Ti=1;
Td=1;
theta=1;% opóŸnienie w [s]
n=5;    %rz¹d aproksymacji

%% charakterystyi czasowe

%obiekt inercyjny I rzêdu
licz1=[0 k];
mian1=[T 1];
%step1=step(licz1,mian1);%odpowied¿ skokowa
%impulse1=impulse(licz1,mian1);
h1=figure;
set(h1,'name','Obiekt inercyjny I rzêdu');
subplot(121),step(licz1,mian1);
subplot(122),impulse(licz1,mian1);
%subplot(143),nyquist(licz1,mian1);%wykres górny dla ujemnych rzeczywistoœci%prawy przycisk->show -> negative frequences bo nie ma ujemnych czêstotliwoœci
%subplot(144),bode(licz1,mian1);

  
%obiekt inercyjny II rzêdu
licz2=[0 0 k];
mian2=[T1*T2 T1+T2 1];
%step2=step(licz2,mian2);%odpowied¿ skokowa
%impulse2=impulse(licz2,mian2);
h2=figure;
set(h2,'name','Obiekt inercyjny II rzêdu');
subplot(1,2,1),step(licz2,mian2);
subplot(1,2,2),impulse(licz2,mian2);

%obiekt ca³kuj¹cy rzeczywisty
licz3=[0 k];
mian3=[Ti*T Ti];
step3=step(licz3,mian3);%odpowied¿ skokowa
impulse3=impulse(licz3,mian3);
figure;
subplot(1,2,1),plot(step3);
subplot(1,2,2),plot(impulse3);

%obiekt ró¿niczkuj¹cy rzeczywisty
licz4=[Td 0];
mian4=[T 1];
step4=step(licz4,mian4);%odpowied¿ skokowa
impulse4=impulse(licz4,mian4);
h4=figure;
subplot(1,2,1),plot(step4);
subplot(1,2,2),plot(impulse4);
%%
%obiekt inercyjny I rzêdu z opóŸnieniem
[licz_op, mian_op] = pade(theta, n);% transmitancjê cz³onu opóŸniaj¹cego - aproksymacja padeogo
licz_iner=[0 k];
mian_iner=[T 1];
[licz5,mian5]=series(licz_op, mian_op, licz_iner, mian_iner);
%step5=step(licz5,mian5);%odpowied¿ skokowa
%impulse5=impulse(licz5,mian5);
h5=figure;
set(h5,'name','Obiekt inercyjny I rzêdu z opóŸnieniem');
subplot(121),step(licz5,mian5);
subplot(122),impulse(licz5,mian5);


%%  charakterystyki czêstotliwoœciowe

%obiekt inercyjny I rzêdu
%licz1=[0 k];
%mian1=[T 1];
h1=figure;
%h=gcf;%get current figure
%get(h)%pokazuje opcje
set(h1,'name','Obiekt inercyjny I rzêdu')
subplot(121),nyquist(licz1,mian1);%wykres górny dla ujemnych rzeczywistoœci%prawy przycisk->show -> negative frequences bo nie ma ujemnych czêstotliwoœci
subplot(122),bode(licz1,mian1);

%obiekt inercyjny II rzêdu
h2=figure;
set(h2,'name','Obiekt inercyjny II rzêdu');
subplot(121),nyquist(licz2,mian2);
subplot(122),bode(licz2,mian2);

%obiekt ca³kuj¹cy rzeczywisty
h3=figure;
set(h3,'name','Obiekt ca³kuj¹cy rzeczywisty');
subplot(121),nyquist(licz3,mian3);
subplot(122),bode(licz3,mian3);

%obiekt ró¿niczkuj¹cy rzeczywisty
h4=figure;
set(h4,'name','Obiekt ró¿niczkuj¹cy rzeczywisty');
subplot(121),nyquist(licz4,mian4);
subplot(122),bode(licz4,mian4);

%obiekt inercyjny I rzêdu z opóŸnieniem
h5=figure;
set(h5,'name','Obiekt inercyjny I rzêdu z opóŸnieniem');
subplot(121),nyquist(licz5,mian5);
subplot(122),bode(licz5,mian5);


%% 

t=0:0.05:5;
dl=length(t);
LiczbaWykresow=12;
y=zeros(dl,LiczbaWykresow);
n=1;
while(n<=LiczbaWykresow)
[licz,mian]=zp2tf([],[-n/4+3*i -n/4-3*i], (n/4)^2+9);
[y(1:dl,n),x,tt]=step(licz,mian,t);
n=n+1;
end
mesh(t,1:12,y');