function [ ps,te ] = pste( Y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if (length(Y) > 30)
    
    area = trapz(Y);
    NewY = Y;
    NewY(NewY<=0) = 0;
    Ppos = trapz(NewY);
    te = area/Ppos;
    if (te == -Inf)
        te = 0;
    end
    te = te*100;
    avr = mean(Y);
    maximum = max(Y);
    ps = avr/maximum;
    ps = ps*100;
else
    ps = 0;
    te = 0;
end
end

