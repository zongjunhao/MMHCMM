function [z] = hcmm_lambda(a, u, lam)
    z = exp(u * lam) - exp(a * u) * (u * lam + 1);
end
