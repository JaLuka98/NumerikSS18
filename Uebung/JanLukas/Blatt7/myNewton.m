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
%% Program name:     myNewton.m
%%
%% Program(version): Octave 4.2.2
%% OS:               x86_64-w64-mingw32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description of the program
% Implementation of newton-raphson to find a root of f. Straightforward and not difficult,
% the algorithm can be found everywhere...
function [x,e,v]=myNewton(f,df,x0) % f is a function handle and df is function handle of the derivative of it. we begin searching at x0
  n = 1; % we store the number of iterations in n
  x(1) = x0; % our first x is obviously the starting point
  if f(x0) ~= 0 % Just in case we hit the root directly, then error is 1 and we never go into the loop at all.
    error = 1;
  else
    error = 0;
  endif
  while error > 1e-12 % We want to be accurate to a degree of 12 decimal places
    v(n) = f(x(n)); % always store the functions values in the v array
    if n >= 50 % In case the method doesnt convergece when dont want to be stuck in an infinite loop
      break;
    endif
    x(n+1) = x(n) - f(x(n))/df(x(n)); % Thats just the newton raphson method
    error =  abs(x(n+1) - x(n)); % Clearly this is the error in estimating the root
    e(n) = error;
    n = n + 1; % we have done one step
  endwhile
endfunction