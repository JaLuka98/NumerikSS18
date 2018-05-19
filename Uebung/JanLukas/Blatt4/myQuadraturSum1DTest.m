1;

function [c]=myQuadraturSum1D(f,w,p,a,b,N)
  sum = 0;
  temp = 0;
  h = (b-a)/N;
  R = length(w);
  phi = zeros(N,R);
  for i = 1:N
    for j = 1:R
      phi(i,j) = h/(R-1)*j - R*h/(R-1)+a+i*h;
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

f = @(x) exp(x);
w = [1/8 3/8 3/8 1/8];
p = [0 1/3 2/3 1];
a = -1;
b = 1;
N = 2;
myQuadraturSum1D(f,w,p,a,b,N)
% This only works for equidistant nodes. Works well, but p is not used and we still
% have to implement 'dynamic', non-equidistant nodes!!

