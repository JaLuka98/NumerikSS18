1;
function [c]=myQuadraturSum1D(f,w,p,a,b,N)
  sum = 0;
  temp = 0;
  h = (b-a)/N
  R = length(w);
  phi = zeros(N,R);
  w = (b-a)/N * w
  for i = 1:N
    for j = 1:R
      phi(i,j) = a + (i-1)*h + p(j)*h;
    endfor
  endfor
  for i = 1:N
    for j = 1:R
      sum += w(j)*f(phi(i,j));
    endfor
    temp += sum;
    sum = 0;
  endfor
  [c] = temp;
endfunction

f = @(x) exp(x)+1;
w = [1/4 1/2 1/4];
p = [0 1/2 1];
a = -1;
b = 1;
N = 3;
myQuadraturSum1D(f,w,p,a,b,N)

