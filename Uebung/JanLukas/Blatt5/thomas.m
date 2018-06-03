1;

function LR = thomas_decompose(A)
  n = rows(A) % okay, since A must be square to have even a LU decomposition
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

function y = forward_solve(LR, b)
  n = length(b);
  y = zeros(n,1); % So that we get a column vector (not strictly necessary)
  % Now we just do forward substitution, noting that L only has two diagonals 
  y(1) = b(1);
  for i = 2:n
    y(i) = b(i) - LR(i,i-1)*y(i-1);
  endfor
endfunction

function x = backward_solve(LR, y)
  n = length(y);
  x = zeros(n,1);
  x(n) = y(n)/LR(n,n);
  for i = n-1:-1:1
    x(i) = (y(i)-LR(i,i+1)*x(i+1))/LR(i,i);
  endfor
endfunction

function LR_Test()
  n = logspace(3,6,4);
  for i = 1:length(n)
    A = gallery('tridiag', n(i), -2, 8, -2);
    b = zeros(n(i),1);
    for j = 1:n(i)
      if j < n/2
        b(j) = 1;
      else
        b(j) = 2;
      endif
    endfor %ending the j for loop
    tic
    LR = thomas_decompose(A);
    toc
    y = forward_solve(LR, b);
    x = backward_solve(LR, y);
    norm(A*x-b)
  endfor % ending the i for loop
endfunction

LR_Test()