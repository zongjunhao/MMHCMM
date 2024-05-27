function [z] = hcmm_lambda(S, s, R, a, u, r, lam)
    z = exp(u * lam) - exp(a * u + u * S / R + u * s / r) * (u * lam + 1);
end
