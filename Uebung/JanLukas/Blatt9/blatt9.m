1;

function [x, numit] = my_jacobi(A,b,x0,eps,maxit)
  xalt = x0;
  for m = 1:maxit
    x = b;
    for i=1:rows(A)
      for j=1:rows(A)
        if j ~= i
          x(i) -= A(i,j)*xalt(j);
        endif
      endfor
      x(i) = x(i) / A(i,i);
    endfor
    xalt = x;
    if norm(A*x-b) < eps*norm(A*x0-b)/norm(x0)
      break;
    endif
    numit = m;
  endfor
endfunction

function [x, numit] = my_jacobi_vector(A,b,x0,eps,maxit)
  temp = diag(A);
  D = diag(temp);
  Dinv = inv(D);
  R = A - D;
  R = A - D;
  x = x0;
  for m = 1:maxit
    x = Dinv * (b - R*x);
    if norm(A*x-b) < eps*norm(A*x0-b)/norm(x0)
      break;
    endif
    numit = m;
  endfor
endfunction

function [x, numit] = my_gauss_seidel(A,b,x0,eps,maxit)
  U = triu(A,1); % upper triangular part of A without main diagonal
  L = tril(A); % lower triangular part of A with main diagonal
  x = x0;
  for m = 1:maxit
    x = b - U*x;
    x = L \ x;
    if norm(A*x-b) < eps*norm(A*x0-b)/norm(x0)
      break;
    endif
    numit = m;
  endfor
endfunction

function [x, numit] = my_sor(A,b,x0,eps,maxit,omega)
  U = triu(A,1); % upper triangular part of A without main diagonal
  L = tril(A,-1); % lower triangular part of A without main diagonal
  temp = diag(A);
  D = diag(temp);
  x = x0;
  for m = 1:maxit
    x = omega*b - (omega*U + (omega - 1)*D)*x;
    x = (D + omega*L) \ x;
    if norm(A*x-b) < eps*norm(A*x0-b)/norm(x0)
      break;
    endif
    numit = m;
  endfor
endfunction

function [A,b] = my_test_system(n)
positions = [1:n];
  t = zeros(n,1);
  t(positions) = 4; % Now we got a vector of size n with every element equal to 4
  T = diag(t); % Diagonal matrix with 4's
  positions = [1:n**2];
  b = zeros(n**2,1);
  b(positions) = -1;
  for i=1:n-1
    T(i,i+1) = -1;
    T(i+1,i) = -1;
  endfor
  A = cell(n);
  for i=1:n
    A(i,i) = T;
    for j=2:n-1
      A(j,j+1) = -eye(n);
      A(j-1,j) = -eye(n);
    endfor 
  endfor
  emptyIndex = cellfun(@isempty,A);       % Find indices of empty cells
  A(emptyIndex) = zeros(n);  
  A = cell2mat(A);
endfunction

for n=2:9
  tic;
  [A, b] = my_test_system(n);
  n
  [~, iterations] = my_jacobi(A,b,b,1e-6,1e8)
  toc;
endfor