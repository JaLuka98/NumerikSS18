%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Numerische Mathematik fuer Physik und Ingenieurwissenschaften 2018     %%%
%%   Programmierabgaben (Praktischer Teil des Uebungungsplattes)            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Student 1: Jan Lukas, SpÃ¤h
%%  Unimail-adress: janlukas.spaeh@tu-dortmund.de
%%
%%  Student 2: Christopher, Krause
%%  Unimail-adress: christopher2.krause@tu-dortmund.de
%%
%%  Student 3: Maximilian, Krebs
%%  Unimail-adress: maximilian.krebs@tu-dortmund.de
%%
%% Uebungszettel-Nr: Blatt 6
%% Aufgabennummer:   6.1
%% Program name:     myBisectTest.m
%%
%% Program(version): Octave 4.2.2
%% OS:               x86_64-w64-mingw32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description of the program
% This program tests the method "mybisect" implemented in mybisect.m to
% numerically calculate a zero of the function f with f(x)=cos(2x)-x^2.
% The starting interval is [0,0.75]. The Behaviour is as expected because
% the length of the interval approximately follows 2^n.

f = @(x) cos(2.*x).^2-x.^2; % Thats the given function
[x,e,v] = mybisect(f,0,0.75) % intial a is 0, initial b is 0.75
semilogy(linspace(1,length(e),length(e)), e) % semilogy plot of the absolute error
save('PA7.1.fig')
print("PA7.1.pdf");
