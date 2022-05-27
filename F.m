function FM = F(gamma, M, AoStar)
a = (1/M);
x = (2/(gamma + 1));
y = (1 + (gamma - 1)/2 * M ^ 2);
z = ((gamma + 1) / (2 * (gamma - 1)));
a = a*(x*y)^z;
FM = a - AoStar;
end