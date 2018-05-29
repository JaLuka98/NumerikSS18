%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Numerische Mathematik fuer Physik und Ingenieurwissenschaften 2018     %%%
%%   Programmierabgaben (Praktischer Teil des Uebungungsplattes)            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Student 1: Jan Lukas, Späh
%%  Unimail-adress: janlukas.spaeh@tu-dortmund.de
%%
%%  Student 2: Christopher, Krause
%%  Unimail-adress: christopher2.krause@tu-dortmund.de
%%
%%  Student 3: Maximilian, Krebs
%%  Unimail-adress: maximilian.krebs@tu-dortmund.de
%%
%% Uebungszettel-Nr: Blatt 2
%% Aufgabennummer:   4.1
%% Program name:     myQuadraturSum1DTest
%%
%% Program(version): Octave 4.2.2
%% OS:               x86_64-w64-mingw32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description of the program
% This program demonstrates numerical integration using summed quadrature rules for
% two different functions and plots the absolute error.

1;
% This function performs numerical integration using a summed quadrature formula.
% Returns: the approximated value of the integral.
% Input: f: function to be integrated; w: vector of weights; p: nodes of the quadrature formula on [0,1]!;
% a: lower limit of integration; b: higher limit of Integration; N: number of Intervals
function [c]=myQuadraturSum1D(f,w,p,a,b,N)
  sum = 0; % define to dummy variables
  temp = 0;
  h = (b-a)/N; % this is the step size
  R = length(w); % This is the amount of nodes per interval
  phi = zeros(N,R);
  w = (b-a)/N * w; % we need to transform the weights according to this formula
  for i = 1:N
    for j = 1:R
      phi(i,j) = a + (i-1)*h + p(j)*h; % phi is a matrix consisting of the nodes from a to b
      % i is the index of the subinterval, while j indexes the nodes in the i-th subinterval
    endfor
  endfor
  for i = 1:N
    for j = 1:R
      sum += w(j)*f(phi(i,j)); % this is straightforward, just do a weighted sum
    endfor
    temp += sum;
    sum = 0;
  endfor
  [c] = temp;
endfunction

f = @(x) exp(x)+1; % we want to integrate this ...
frunge = @(x) 1./(1+25*x.^2); % and the runge function
wTrapez = [1/2 1/2]; % these are the weights for the trapezodial rule
pTrapez = [0 1]; % nodes for trapezodial rule in [0,1].
wSimpson = [1/6 4/6 1/6]; % simpsons rule weights
pSimpson = [0 1/2 1]; % and nodes
% for f
exactSolution = e % this is the exact solution of integral f(x) from 0 to 1
% we now want to calculate the value of the integral approximated by trapezodial and simpson rule for different numbers of intervals (1 to 1000)
for n=1:1000
  approximateSolutionTrapez(n) = myQuadraturSum1D(f, wTrapez, pTrapez, 0, 1, n);
endfor
errortrapez = abs(approximateSolutionTrapez - exactSolution); % this is the absolute error (not signed)
loglog(linspace(1,1000,1000), errortrapez) % make a loglog plot of the absolute error
% do it again for simpson rule
grid on
hold on
for n=1:1000
  approximateSolutionSimpson(n) = myQuadraturSum1D(f, wSimpson, pSimpson, 0, 1, n);
endfor
errorsimpson = approximateSolutionSimpson - exactSolution;
loglog(linspace(1,1000,1000), errorsimpson)
hold off
save("myQuadraturSum1DPlotf")
print("myQuadraturSum1DPlotf.png")
% For frunge
% do it again for runges function
exactSolution = 2*atan(5)/5
for n=1:1000
  approximateSolutionTrapez(n) = myQuadraturSum1D(frunge, wTrapez, pTrapez, -1, 1, n);
endfor
errortrapez = abs(approximateSolutionTrapez - exactSolution);
loglog(linspace(1,1000,1000), errortrapez)
grid on
hold on
for n=1:1000
  approximateSolutionSimpson(n) = myQuadraturSum1D(frunge, wSimpson, pSimpson, -1, 1, n);
endfor
errorsimpson = abs(approximateSolutionSimpson - exactSolution);
loglog(linspace(1,1000,1000), errorsimpson)
hold off
save("myQuadraturSum1DPlotrunge")
print("myQuadraturSum1DPlotrunge.png")

% Das Ergebnis ist eigentlich wie erwartet. Beide Verfahren konvergieren gegen den wahren
% Wert, da der Fehler rasch klein wird. Außerdem weißt die Simpsonregel schnellere Konvergenz auf.
% Das liegt daran, dass eine Gerade mit höherer Steigung bei loglog eine höhere Potenz bedeutet.
% Beide Regeln machen bei der Runge-Funktion allerdings komische Dinge, nichtsdestotrotz integrieren
% sie insgesamt mit steigendem N besser.
% Die Oszillationen bei der Simpsonregel bei N circa 1000 bei f(x) liegen daran, dass dort
% bereits die Maschinengenauigkeit langsam erreicht wird.