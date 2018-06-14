function [x,e,v]=myNewton(f,df,x0)
  n = 1;
  x(1) = x0;
  if f(x0) ~= 0
    error = 1;
  else
    error = 0;
  endif
  while error > 1e-12
    v(n) = f(x(n));
    if n >= 50
      break;
    endif
    x(n+1) = x(n) - f(x(n))/df(x(n));
    error =  abs(x(n+1) - x(n));
    e(n) = error;
    n = n + 1;
  endwhile
endfunction