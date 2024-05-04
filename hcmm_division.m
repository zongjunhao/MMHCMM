function [z] = hcmm_division(fun, a, u, x, A, B)
    p = -1;

    while (fun(a, u, A) * fun(a, u, B) <= 0) && (abs(A - B) > x)
        c = (A + B) / 2;

        if fun(a, u, c) * fun(a, u, B) <= 0
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
