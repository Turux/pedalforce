function [NP,P_avg] = NP(power)
    
P_avg = mean(power);

NP = (mean(power.^4))^.25;

P_avg = round(P_avg);
NP = round(NP);

end