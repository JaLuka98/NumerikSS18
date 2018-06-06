clear all;

ntest = [100, 1000, 10000];
m = size(ntest);
t = zeros(1,m);
l = 0;

for n = ntest
    l = l + 1;
    x = ((n-1):-1:0) / n;
    b = ones(n,1); b(ceil(n/2):end) = b(ceil(n/2):end) * 2;
    A = full(gallery('tridiag',n,-2,8,-2));
    tic;
    LR = LR_decompose(A);
    % changed from t(1)=toc
    toc;
    y = forward_solve(LR,b);
    x = backward_solve(LR,y);
    disp(sprintf('n = %d:     ||A*x-b||_2 = %e', n, norm(A*x-b,2)));
end
