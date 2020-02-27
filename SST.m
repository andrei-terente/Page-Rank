function [x] = SST(A, b)
    if max(max(abs(tril(A, -1)))) > 10^3 * eps
        disp('The matrix A is not upper triangular!');
        x = NaN;
        return;
    endif

    n = length(b);
    x = zeros(n, 1);

    x(n) = b(n) / A(n, n);

    for i = (n - 1): -1 : 1
        sum_of_xs = A(i, (i + 1) : n) * x((i + 1) : n, 1);
        x(i) = (b(i) - sum_of_xs) / A(i, i);
    endfor
endfunction