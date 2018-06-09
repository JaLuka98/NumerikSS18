f = @(x) cos(2.*x).^2-x.^2; % Thats the given function
[x,e,v] = mybisect(f,0,0.75) % intial a is 0, initial b is 0.75
semilogy(linspace(1,length(e),length(e)), e) % semilogy plot of the absolute error
save('PA7.1.fig')
print("PA7.1.pdf");