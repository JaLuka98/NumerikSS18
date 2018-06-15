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
%% Uebungszettel-Nr: Blatt 7
%% Aufgabennummer:   7.1
%% Program name:     myNewtonTest.m
%%
%% Program(version): Octave 4.2.2
%% OS:               x86_64-w64-mingw32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description of the program
% Testing and comparing the two methods. Quite clearly the error is behaving as expected.
% The error of the bisection method is decreasing exponentially (semilog) while
% the approximation of the root with newton-raphson doubles in correct digits with each iteration.

f = @(x) cos(2.*x).^2 - x.^2; % That is the function we want to get a root of
df = @(x) -2 * (x + sin(4.*x)); % df is f'(x)

[xb,eb,vb] = mybisect(f,0,0.75)
[xn,en,vn] = myNewton(f,df,0.75)
semilogy(linspace(1,length(eb),length(eb)),eb, "Bisection method")
hold on
semilogy(linspace(1,length(en),length(en)),en, "Newton-Raphson method")
hold off
legend (h, "location", "northeast");
title ("Comparison of the convergence rate of Newton-Raphson method and bisection method.");
save('plot.fig')
print("plot.pdf");