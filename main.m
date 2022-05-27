function main()
close all

P_e = 16.8727*1e3;
PO = 20.4*1e6;
TO = 3500;
gamma = 1.22;
eps = 1E-4;
R_u = 8314.4612;
MW = 22;
R_g = R_u/MW;
gO = 9.8067;


[x, x_choked, z, A_star] = Read_SSME();

%ghi gop luon cong thuc
a = PO/P_e;
b = (gamma - 1) / gamma;
c = 2 / (gamma - 1);
M_e = sqrt(c * (a ^ b - 1));

L = length(x);
M = zeros(1, L);
PoPO = M;
T = M;

if M_e <= 1
    fprintf('Massflow is unchoked, please increase...');
else
    for i =1:L
        A = pi .* z(i) .^2;
        AoAstar = A/A_star;
        if x(i) < x_choked
            M_est = 0.01;
        else
            M_est = 5;
        end       
        M(i) = num_slvr_Mach(gamma, M_est, AoAstar, eps);
        k = 1 + (gamma -1)/2 * M(i)^2;
        l = k ^ ((gamma) / (gamma - 1));
        PoPO(i) = 1/ l;
        T(i) = TO/k;
    end
end

figure()
plot(x*100, M, 'm')
title('Mach number vs. X-Position, [cm]')
xlabel('X-position, [cm]')
ylabel('Mach number')
xticks(0:25:350)
xticklabels(0:25:350)
yticks(0:0.5:5)
yticklabels(0:0.5:5)
grid on 
grid minor

figure()
plot(x*100, PoPO, 'm')
title('P/PO vs. X-position, [cm]')
xlabel('X-position, [cm]')
ylabel('P/P0');
xticks(0:25:350)
xticklabels(0:25:350)
yticks(0:0.1:1)
yticklabels(0:0.1:1)
grid on 
grid minor

figure()
plot(x*100, T, 'm')
title('Temperature, [K], vs. X-position, [cm]')
xlabel('X-position, [cm]')
ylabel('Temperature, [K]')
axis([0 350 800 3600])
xticks(0:25:350)
xticklabels(0:25:350)
yticks(800:200:3600)
yticklabels(800:200:3600)
grid on 
grid minor

M_exit = M(L);
T_e = T(L);
A_e = pi .* z(L) .^ 2;
V_e = M_exit * sqrt(gamma*R_g*T_e);
m_dot_e = sqrt(gamma/R_g * (2/(gamma+1))^((gamma+1)/(gamma - 1)))*PO/sqrt(TO)*A_star;
Thrust_vac = m_dot_e*V_e + P_e*A_e;
Isp_vac = Thrust_vac/(gO*m_dot_e);
fprintf('T_exit                  = %.4f [K].\n', T_e);
fprintf('V_exit                  = %.4f [m/s].\n', V_e);
fprintf('M_dot_e                 = %.4f [kg/s].\n', m_dot_e);
fprintf('Thrust in vacum         = %.4f [kN].\n', Thrust_vac/1E3);
fprintf('Isp in vacum            = %.4f [s].\n', Isp_vac);

        



