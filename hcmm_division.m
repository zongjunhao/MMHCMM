function [z] = hcmm_division(fun, S, s, R, a, u, r, x, A, B)
    p = -1;

    while (fun(S, s, R, a, u, r, A) * fun(S, s, R, a, u, r, B) <= 0) && (abs(A - B) > x)
        c = (A + B) / 2;

        if fun(S, s, R, a, u, r, c) * fun(S, s, R, a, u, r, B) <= 0
            A = c;
            p = p + 1;
        else
            p = p + 1;
            B = c;
        end

    end

    % sprintf('二分次数为:%d',p)
    % sprintf('结果区间为:%f,%f,结果为:%f',A,B,(A+B)/2 )
    z = (A + B) / 2;
end
