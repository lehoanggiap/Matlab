function dF_dM = dFdM(gamma, M)
a = (2 ^ ((1 - 3 * gamma) / (2 - 2 * gamma)));
b = ((M ^2 - 1) / (M^2 * (2 + M ^ 2 * (gamma - 1))));
c = (((1 + (gamma - 1) / 2 * M ^ 2) / (gamma + 1))^((gamma + 1) / (2 * (gamma - 1))));
dF_dM = (a * b * c);
end