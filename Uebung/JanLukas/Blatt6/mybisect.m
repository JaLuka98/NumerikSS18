function [x,e,v]=mybisect(f,x00,x0)
  % first we rename the bounds of the interval
  a = x00; 
  b = x0;
  n = 0; %number of iterations needed, starting at 1 inside the loop
  error = b - a; % the initial error is just the length of the interval
  while error > 1e-12
    n = n + 1; % every time we go through the loop we add 1 to n
    x(n) = (b + a) / 2; % thats just the middle of the new interval
    error = abs(b - x(n)); % Thats fine because biection is symmetric
    e(n) = error;
    v(n) = f(x(n)); % we want to give back the values of the function at the new bounds of the intervals as well
    if f(a)*f(x(n)) < 0 % if the sign change occurs within [a_n,x_n] 
      b = x(n); % change the interval to [a_n,x_n]
    elseif f(x(n))*f(b) < 0 % the same for [x_n, b_n]
      a = x(n);
     elseif f(x(n)) == 0 % Just in case we hit the point which probably wont happen
      a = x(n);
      b = x(n);
    endif
  end
endfunction
