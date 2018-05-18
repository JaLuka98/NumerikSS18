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
%% Aufgabennummer:   2.1
%% Program name:     MyNewtonInterpolTest
%%
%% Program(version): Octave 4.2.2
%% OS:               x86_64-w64-mingw32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description of the program
% This program demonstrates the behaviour of interpolation polynomials for the runge
% function with an increasing amount of nodes.

runge = @(x) 1./(1+25.*x.^2); % Define the runge function f(x)=1/(1+25x^2). This function will be interpolated 
m = 100; % 101 values in the delta array
delta = zeros(m,1);
for k = 1:m+1
  delta(k) = -1 + 2*(k-1)/m;
endfor

% Returns an array of newton coefficients for interpolation.
% Interpolates the f values at x.
function [c] = myNewtonInterpol(x,f)
	n = length(x);
  for i = 1:n
    c(i) = divdiff(x, f, 1, i);
  endfor
endfunction

% Rete divided difference of the values stored in the y-array with respect to the values stored in the x-array
% The indexing begins at x0 and ends at x1
function coeff = divdiff(x, y, x0, x1)
	if x0 == x1 
		coeff = y(x0);
	else
		coeff = (divdiff(x, y, x0 + 1, x1) - ...
			divdiff(x, y, x0, x1 - 1)) / ...
			(x(x1) - x(x0));
	end
endfunction

% Evaluation of the polynomial with coefficients c_i (modified horners method)
% it is evaluated at x with s being the nodes of the interpolation
function y = polynom(x,s,c)
	n = length(s);
  y = c(n);
	for(k=n-1:-1:1)
		y = c(k)+(x-s(k)).*y;
	end
end

% Returns an array of n chebyshev nodes in the Interval [-1,1]
function [nodes] = cheby(n)
  nodes = zeros(n,1);
  for j=1:n
    nodes(j) = cos((2*j-1)*pi/(2*n));
  endfor
 end
 
n = [7, 12, 17]; % We want to try 3 different numbers of nodes
length(delta)
for i=1:3 % Loop over the three n's
  newtoncoefficientsequi = zeros(n(i),1); % This is an array where the coefficients of the Newton Interpolation polynomial are stored
  figure(i) % Create a different figure for each number of nodes
  xlin = linspace(-1, 1, 300); % The x-values where the function is evaluated
  flin = runge(xlin); % Create an array of the f_runge(x) for xlin
  xequi = zeros(n(i),1); % Create a new array full of zeros of the size of the amount of nodes
  % This array will contain the x-coordinates of the equidistant nodes
  % The equation is given in the assignment
  for j=1:(n(i)+1)
    xequi(j) = -1 + 2*(j-1)/n(i);
  endfor
  % After this loop the x-array contains equidistant x-coordinates from -1 to 1
  fequi = runge(xequi); % Calculate the value of runges function at the nodes so we can interpolate it
  newtoncoefficientsequi = myNewtonInterpol(xequi, fequi); % Call the function myNewtonInterpol to get the coefficients for the equidistant nodes
  interpolationequi = zeros(1,100); 
  interpolationequi = polynom(xlin, xequi, newtoncoefficientsequi); % Now we have the array interpolation which contains the y-values of the interpolation polynomial (equidistant nodes)
  xcheby = zeros(n(i),1); % Create a new array of full of the size of the amount of nodes
  xcheby = cheby(n(i)+1); % Store chebychev distributed nodes in the array
  fcheby = runge(xcheby); % Evaluate f at the cheby nodes and store the values in fcheby
  newtoncoefficientscheby = zeros(n(i),1); % Same procedure as above, but now we have chebychev nodes
  newtoncoefficientscheby = myNewtonInterpol(xcheby, fcheby);
  interpolationcheby = zeros(1,100); 
  interpolationcheby = polynom(xlin, xcheby, newtoncoefficientscheby);
  plot(xlin, flin, "g", xequi, fequi, "r*", xcheby, fcheby, "b*", xlin, interpolationequi, "r", xlin, interpolationcheby, "b") % Plot everything we want to plot
  filename = sprintf('%s_%d','PA2-1-N',n(i)); % Create the correct filename
  save(filename); % Save the plot
  temp = zeros(10,1); % This is just a dummy array
  % Here we calculate the maximum error of the polynomial interpolation by slicing the [-1,1] interval into 101 points ...
  % ... and calculating the error abs(f_runge(x)-p(x)) for each of these points.
  % After that we let octave search for the maximum value in temp and we got it.
  for k=1:101
    temp(k) = abs(runge(delta(k)) - polynom(delta(k), xequi, newtoncoefficientsequi));
  endfor
  printf("Maxerror gleich %d ", max(temp))
  printf("fuer %d ", n(i) + 1)
  printf("aequidistante Stuetzstellen\n")
  for k=1:101
    temp(k) = abs(runge(delta(k)) - polynom(delta(k), xcheby, newtoncoefficientscheby));
  endfor
  printf("Maxerror gleich %d ", max(temp))
  printf("fuer %d ", n(i)+1)
  printf("chebychev-verteilte Stuetzstellen\n")
endfor

% Leider wissen wir nicht, was mit "Schreiben sie ein Skript myNewtonInterpolTest()
% gemeint ist. Unser Programm ist ja quasi schon das Skript. Wir hoffen, das ist okay so.
% Es ist vielleicht nicht der effizienteste und schoeneste Code. Sollte das Programm also nicht zu potte kommen,
% kann man den linspace kleiner machen oder ähnliches, damit es auch in angemessener Zeit terminiert. Sorry dafuer :/
% Beobachtungen: Fuer 8 Stuetzstellen sind das aequidistante und Tschebyscheff-Interpolationspolynom beide nicht so passend,
% da kein Punkt in der Nähe von x = 0 gewaehlt wird. Deswegen ist der Feler groß und für Tschebyscheff
% schlechter als für aequi. Allerdings ist ein leichtes Ueberschießen am Rand für die rote Kurve schon jetzt zu sehen.
% Fuer 13 Stuetzstellen ist das erwartete Verhalten klar zu sehen. Tschebyscheff-Stuetzstellen gewichten den Rand des Intervalls
% viel mehr und koennen die Runge-Funktion dort viel besser darstellen. Die rote Kurve hat, wie klar
% zu sehen ist, einen untolerierbar hohen Fehler. Das gleiche sieht man für 18 Stuetzstellen, dort stellt die blaue Kurve
% für praktische Zwecke bereits eine gute Approximation dar, die rote versagt an den Intervallenden wieder völlig, ist jedoch um 0 (bis circa +-0.5)
% noch eine gute Interpolation.
% Der absolute Fehler wird stets durch das Programm ausgegeben. Die Werte stimmen mit dem an den Graphen beobachteten Verhalten gut ueberein.