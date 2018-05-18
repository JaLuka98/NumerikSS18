1;

function [c]=myQuadratur1D(f,w,x)
  sum = 0;
  for k=1:length(x)
    sum += w(k)*f(x(k));
  endfor
  [c] = sum;
endfunction

f = @(x) exp(x) + 1;

x1 = [0 1];
w1 = [1/2 1/2];
x2 = [0 1/2 1];
w2 = [1/6 4/6 1/6];
myQuadratur1D(f,w1,x1)
myQuadratur1D(f,w2,x2)