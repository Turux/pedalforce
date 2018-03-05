function [ cutsignal, diff, ci, mu, stmu ] = crossc( s1, s2 )

% @Brief:   A function that executes and plot cross-correlation
%           between two discrete series (1D arrays).
% @Requires:"CI.m" Confidence Interval Function
% @Param:   s1        -> discrete series 1
%           s2        -> discrete series 2
% @Returns: cutsignal -> realigned and cutted version of the longer series
%           diff      -> array of difference between the two series after
%                        realign
%           ci        -> confidence interval of the difference
%           mu        -> mean of the difference  
% @Extra:   figure1   -> plot of the shortes series and the cutted version
%                        of the longest. 
%                        Cross-correlation between the two series
%           figure2   -> plot of 'diff' and 'mu'                   

% figure
if (length(s1) >= length(s2))  
    [acor,lag] = xcorr(s2,s1);
else 
    [acor,lag] = xcorr(s1,s2);
end

[~,I] = max(abs(acor));
lagDiff = lag(I);
% subplot(2,1,2)
% plot(lag,acor)
% 
% subplot(2,1,1)

if (length(s1) > length(s2))
    alpower = s1(-lagDiff+1:end);
    cutsignal = alpower(1:length(s2));

elseif (length(s1) == length(s2))
    if(lagDiff == 0)
        alpower = s1;
        cutsignal = alpower;
    else
    alpower = s1(lagDiff:end);
    cutsignal = alpower(1:length(s2));
    end
    
%     plot(s2)
%     hold
%     plot(cutsignal)
%     hold
else
    alpower = s2(-lagDiff+1:end);
    cutsignal = alpower(1:length(s1));
%     plot(s1)
%     hold
%     plot(cutsignal)
%     hold
end

% figure
if (length(s1) >= length(s2))
diff = cutsignal-s2;

else
diff = cutsignal-s1;

end
% plot(diff)
% hold
mu = mean(diff);
stmu = std(diff);
% hline = refline([0 mu]);
% hline.Color = 'r';
% hold
ci = CI(diff);


end

