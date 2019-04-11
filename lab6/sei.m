
clear all;
close all;


%Kkr=8m -wzmocnienie krytyczne
%Pkr=3.7 - okres oscylacji - czas trwania jednego cyklu
%zamiast metody prób i b³edów linie pierwiastkowe
%P=Kkr I=Ti D=Td
%P=0.5Kr = 4 => Pkr=3,7(wykres)
close all;

o=zpk([],[-1 -1 -1],1);
rlocus(o);
sgrid;
pause;
[K,bieguny]=rlocfind(o); %K=8 - oscylacje(przeciêcie z osi¹ urojon¹-granica stabilnoœci)


