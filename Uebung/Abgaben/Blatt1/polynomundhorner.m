%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Numerische Mathematik fuer Physik und Ingenieurwissenschaften 2018     %%%
%%   Programmierabgaben (Praktischer Teil des Uebungungsplattes)            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Student 1: Jan Lukas, Sp�h
%%  Unimail-adress: janlukas.spaeh@tu-dortmund.de
%%
%%  Student 2: Christopher, Krause
%%  Unimail-adress: christopher2.krause@tu-dortmund.de
%%
%%  Student 3: Maximilian, Krebs
%%  Unimail-adress: maximilian.krebs@tu-dortmund.de
%%
%% Uebungszettel-Nr: Blatt 1
%% Aufgabennummer:   2.2
%% Program name:     polynomundhorner
%%
%% Program(version): Octave 4.2.2
%% OS:               x86_64-w64-mingw32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program plots the graph of the polynomial f(x)=(x-1)^7 in the range of
% 0.8 to 1.2 with step size 5*10-5 using two different methods:
% 1. Direct evaluation.
% 2. Evaluation with horners method:
% f(x)=((((((x - 7)*x + 21)*x - 35)*x + 35)*x - 21)*x + 7)*x - 1
% Note that .* is used in the program to have element-wise multiplication.

x = single(0.8:0.00005:1.2)
figure(1);
plot(x, (x -1).^7)
xlim([0.8,1.2]);
print("direktespolynom.png")
figure(2);
plot(x, ((((((x - 7).*x + 21).*x - 35).*x + 35).*x - 21).*x + 7).*x - 1)
xlim([0.8,1.2]);
print("hornerpolynom.png")

% Es wird beobachtet, dass trotz kleiner Schrittweite die direkte Auswertung zu
% einem deutlich genaueren Graph führt. Dies wird daran erkannt, dass der Graph
% mit dem Horner-Schema oszilliert, dies wird bei diesem Polynom nicht erwartet.
% Gewöhnlicherweise ist das Horner-Schema gegenüber einer Auswertung in Monombasis
% zu bevorzugen, da es oft numerisch stabiler ist. Hier ist aber die Auswertung
% in maximal vereinfachter Form als faktorisierte Form zu bevorzugen, da nur eine
% Subtraktion ausgeführt wird. Additionen bzw. Subtraktionen benachbarter Zahlen
% können zu Auslöschung führen und bei Horner wird viel subtrahiert. Dies erklärt
% das unerwünschte Verhalten des Graphen.
