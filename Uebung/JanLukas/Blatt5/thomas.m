%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Numerische Mathematik fuer Physik und Ingenieurwissenschaften 2018     %%%
%%   Programmierabgaben (Praktischer Teil des Uebungungsplattes)            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  Student 1: Jan Lukas, Sp√§h
%%  Unimail-adress: janlukas.spaeh@tu-dortmund.de
%%
%%  Student 2: Christopher, Krause
%%  Unimail-adress: christopher2.krause@tu-dortmund.de
%%
%%  Student 3: Maximilian, Krebs
%%  Unimail-adress: maximilian.krebs@tu-dortmund.de
%%
%% Uebungszettel-Nr: Blatt 5
%% Aufgabennummer:   5.1
%% Program name:     thomas.m
%%
%% Program(version): Octave 4.2.2
%% OS:               x86_64-w64-mingw32
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Description of the program
% In this program the thomas algorithm is implemented. It is used to LU decompose
% a tridiagonal matrix A into L*R, so that A=L*R.

1;

% This function gets a square tridiagonal matrix A and gives back the Matrix LR
% In this matrix both L and R are stored. The main diagonal and the upper diagonal hold all non zero
% matrix elements of R while the lower diagonal holds the non zero and non one elements of L.
% The form of the algorithm presented in the lecture with auxiliary vectors alpha, beta, gamma
% is commented out while the quick version is implemented.
function LR = thomas_decompose(A)
  n = rows(A) % okay, since A must be square to have even a LU decomposition
  % No further comments, the algorithm is wideley known and was presented in lecture
  LR = spalloc(n,n,3*n);
  %alpha = zeros(n,1);
  %beta = zeros(n,1);
  %gamma = zeros(n,1);
  % i = 1 step
  %alpha(1) = A(1,1)
  %beta(1) = A(1,2)
  LR(1,1) = A(1,1);
  LR(1,2) = A(1,2);
  % i = 2:n-1 step
  for i = 2:n-1
    %gamma(i) = A(i,i-1)/alpha(i-1)
    LR(i,i-1) = A(i,i-1)/LR(i-1,i-1);
    %alpha(i) = A(i,i) - gamma(i)*beta(i-1)
    LR(i,i) = A(i,i) - LR(i,i-1)*LR(i-1,i);
    %beta(i) = A(i,i+1)
    LR(i,i+1) = A(i,i+1);
  endfor
  % i = n step
  %gamma(n) = A(n,n-1)/alpha(n-1)
  LR(n,n-1) = A(n,n-1)/LR(n-1,n-1);
  %alpha(n) = A(n,n)-gamma(n)*beta(n-1)
  LR(n,n) = A(n,n)-LR(n,n-1)*LR(n-1,n);
endfunction

% This function uses forward substitution to solve the first step of solving Ax=b.
% The equation is Ly = b, input is LR in the form given back by thomas_decompose and the right-hand side 
% b. Output is vector y.
function y = forward_solve(LR, b)
  n = length(b);
  y = zeros(n,1); % So that we get a column vector (not strictly necessary)
  % Now we just do forward substitution, noting that L only has two diagonals 
  y(1) = b(1);
  for i = 2:n
    y(i) = b(i) - LR(i,i-1)*y(i-1);
  endfor
endfunction

% Now the vector x is calculated through backward substitution. Nothing complicated
% Since R is twodiagonal, solving Rx = y is  straightforward, simply calculate x(n), then x(n-1),...
function x = backward_solve(LR, y)
  n = length(y);
  x = zeros(n,1);
  x(n) = y(n)/LR(n,n);
  for i = n-1:-1:1
    x(i) = (y(i)-LR(i,i+1)*x(i+1))/LR(i,i);
  endfor
endfunction

function LR_Test()
  n = logspace(1,6,6);
  for i = 1:length(n)
    A = gallery('tridiag', n(i), -2, 8, -2); % This was given in the assignment.
    b = zeros(n(i),1); % The b vector as well...
    for j = 1:n(i)
      if j < n/2
        b(j) = 1;
      else
        b(j) = 2;
      endif
    endfor %ending the j for loop
    tic % Measure time from here...
    LR = thomas_decompose(A); % Get decomposition of A and store it in LR.
    toc % ... to here.
    y = forward_solve(LR, b);
    x = backward_solve(LR, y);
    norm(A*x-b) % The residue of the system of equations. The smaller it is the better the algorithm 
  endfor % ending the i for loop
endfunction

LR_Test()

% Beobachtungen: Der Algorithmus scheint korrekt programmiert zu sein. Das Residuum ist klein, im Rahmen
% der Maschinengenauigkeit. Es war angegeben, die Laufzeit zu pr¸fen. Im Rahmen von n=10 bis n=100000
% steigt die Laufzeit etwa wie O(n) wie theoretisch zu erwarten ist. Leider steigt dann die Laufzeit ¸berproportional
% von circa 15 auf circa 963 Sekunden (bei n=1000000). Wir kˆnnen uns das so nicht erkl‰ren. Da die Laufzeit ab dann wahrscheinlich
% noch steiler ansteigt, wird nur dieser Bereich gepr¸ft.

% Mit dem von Ihnen angegebenen Vergleichsprogramm kann nur begrenzt verglichen werden.
% Auf unseren Rechnern terminiert dies ab n=10000 nicht mehr in absehbarer Zeit. Was haben wir falsch gemacht? :/
% Im Bereich n=10 bis n=1000 steigt die Rechenzeit des Vergleichsprogramms linear an. Insofern wird der Schluss gezogen,
% dass mindestens in diesem Bereich beide Programme sehr gut und ‰hnlich arbeiten.