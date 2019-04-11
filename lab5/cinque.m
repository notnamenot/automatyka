%zad1
%Linie pierwiastkowe - pokazuj� jak b�d� si� przemieszcza� bieguny gdy wzmocnienie K b�dzie ros�o
close all;

o1=zpk([], [-1 -1/5], 1/5); 
o2=zpk(-2, [-1 -1/5], 1/10 );
o3=zpk([], [-1 -1/5 -2], 2/5);

figure;
subplot(1,3,1),rlocus(o1); %zawsze po lewej-zawsze stabilny ;rysowanielini pierwiastkowyh
subplot(1,3,2),rlocus(o2);%zawsze po lewej-zawsze stabilny
subplot(1,3,3),rlocus(o3);%dla odpowiednio du�ego K bieguny przechodz� na praw� stron�- uk�ad staje si� niestabilny 

%% zad2
close all;

syso=zpk([],[0 -1 -5], 5);
figure;
rlocus(syso);     %rysowanie linii pierwiastkowych 
line([0 -1],[0 1]); %narysowanie p�prostej pod k�tem 45?
sgrid;
pause;
[K,bieguny] = rlocfind(syso); %Aby odczyta� to wzmocnienie krytyczne
sysz = feedback(syso*K, 1);%!

%%step(sysz)
%%%2b

sysc=zpk(-1, -10, 10);  %kompensator (cz�on przyspieszaj�co-op�niaj�cy faz�)
sys = series(syso,sysc);%chyba mo�na po prostu mno�y�systemy

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

%%uk�ad z kompensatorem szybciej si� ustala
%%Jak wida� na wykresie uk�ad ten ma wi�ksz� cz�stotliwo�� drga� w�asnych co wskazuje na trudniejsze wprawienie tego uk�adu w drgania.