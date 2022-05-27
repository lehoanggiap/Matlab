function M = num_slvr_Mach(gamma, M, AoAstar, eps)
while 1
    FM = F(gamma, M, AoAstar);
    dF_dM = dFdM(gamma, M);
    M = M - FM/dF_dM;
    err = abs(FM) / (AoAstar);
    if err < eps
        break
    end    
end
end