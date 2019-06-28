function [] = syncr(ax1,ax2)
%SYNCR Summary of this function goes here
%   Detailed explanation goes here
r1=ax1.RLim(2);
r2=ax2.RLim(2);
    if(r1>=r2)
        ax2.RLim(2)=r1;
    else
        ax1.RLim(2)=r2;
    end
end

