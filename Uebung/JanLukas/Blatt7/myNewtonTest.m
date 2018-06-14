f = @(x) cos(2.*x).^2 - x.^2;
df = @(x) -2 * (x + sin(4.*x));

[xb,eb,vb] = mybisect(f,0,0.75)
[xn,en,vn] = myNewton(f,df,0.75)
semilogy(linspace(1,length(eb),length(eb)),eb)
hold on
semilogy(linspace(1,length(en),length(en)),en)
hold off
save('plot.fig')
print("plot.pdf");