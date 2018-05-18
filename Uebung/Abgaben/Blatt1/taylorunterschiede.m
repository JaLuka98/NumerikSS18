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
%% Aufgabennummer:   2.1
%% Program name:     Taylorunterschiede
%%
%% Program(version): Octave 4.2.2
%% OS:               x86_64-w64-mingw32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description of the program
% Intput: none
% Output: Approximation of the natural exponential function f(x)=exp(x) by its
% taylor series truncated at n = 3,6,9,...,30. The value of exp(-5.5) shall be
% calculated using three methods:
% 1. Direct approximation (x = -5.5 in the truncated taylor series)
% 2. Calculate approximate value for exp(5.5) through truncated taylor series and print 1/exp(5.5)=exp(-5.5)
% 3. Calculate approximate value for exp(-0.5) and raise to the power of 11 and print it.
% The first number printed is the approximation for exp(-5.5) and the second value is
% the relative error in comparison with the octave value for exp(-5.5).

format long
exp(-5.5)
f = @(x, k) (x).^k ./factorial(k)
for i = 3:3:30
  printf('n =')
  disp(i)
  sum(f(-5.5, [0:i]))
  (sum(f(-5.5, [0:i]))-exp(-5.5))/exp(-5.5)
 end
for i = 3:3:30
  printf('n =')
  disp(i)
  1/sum(f(5.5, [0:i]))
  (1/sum(f(5.5, [0:i]))-exp(-5.5))/exp(-5.5)
 end
for i = 3:3:30
  printf('n =')
  disp(i)
  sum(f(-0.5, [0:i]))^11
  (sum(f(-0.5, [0:i]))^11-exp(-5.5))/exp(-5.5)
 end

 %1. Die erste Methode ist nicht zu empfehlen, da eine alternierende Summe recht
 %langsam konvergiert.
 %2. Die zweite Methode ist besser als die erste, allerdings wird exp(5.5) durch ein
 %Taylorpolynom um 0 angen�hert, sodass einige Terme ben�tigt werden, um zufriedenstellende
 %Genauigkeit zu erzielen.
 %3. Die dritte Methode ist deutlich besser, da der Entwicklungspunkt x_0=0 von
 %der Berechnungsstelle x = 0.5 nicht weit entfernt ist und die Summanden keine
 %alternierenden Vorzeichen haben.
 %Auff�llig ist insbesondere, dass besonders bei der 3. Methode der relative Fehler
 %nicht geringer als circa. -1.91 * 10^-15 sein kann. Dort scheint gerade die
 %Maschinengenauigkeit des Formats long erreicht worden sein.
