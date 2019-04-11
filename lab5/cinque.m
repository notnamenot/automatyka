%zad1
%Linie pierwiastkowe - pokazuj¹ jak bêd¹ siê przemieszczaæ bieguny gdy wzmocnienie K bêdzie ros³o
close all;

o1=zpk([], [-1 -1/5], 1/5); 
o2=zpk(-2, [-1 -1/5], 1/10 );
o3=zpk([], [-1 -1/5 -2], 2/5);

figure;
subplot(1,3,1),rlocus(o1); %zawsze po lewej-zawsze stabilny ;rysowanielini pierwiastkowyh
subplot(1,3,2),rlocus(o2);%zawsze po lewej-zawsze stabilny
subplot(1,3,3),rlocus(o3);%dla odpowiednio du¿ego K bieguny przechodz¹ na praw¹ stronê- uk³ad staje siê niestabilny 

%% zad2
close all;

syso=zpk([],[0 -1 -5], 5);
figure;
rlocus(syso);     %rysowanie linii pierwiastkowych 
line([0 -1],[0 1]); %narysowanie pó³prostej pod k¹tem 45?
sgrid;
pause;
[K,bieguny] = rlocfind(syso); %Aby odczytaæ to wzmocnienie krytyczne
sysz = feedback(syso*K, 1);%!

%%step(sysz)
%%%2b

sysc=zpk(-1, -10, 10);  %kompensator (cz³on przyspieszaj¹co-opóŸniaj¹cy fazê)
sys = series(syso,sysc);%chyba mo¿na po prostu mno¿yæsystemy

figure;
rlocus(sys);
line([0 -4],[0 4]);
sgrid;
pause;
[K1, bieguny1]=rlocfind(sys);
sysz2 = feedback(sys*K1, 1);

%%step(sysz2)

figure;
step(sysz,sysz2);
legend('bez kompensatorem','z kompensatorem')

%%uk³ad z kompensatorem szybciej siê ustala
%%Jak widaæ na wykresie uk³ad ten ma wiêksz¹ czêstotliwoœæ drgañ w³asnych co wskazuje na trudniejsze wprawienie tego uk³adu w drgania.