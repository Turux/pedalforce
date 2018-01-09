function [ ci, mu ] = CI( x )

% @Brief:   A function that calculates Confidence Interval of a series 
% @Param:   x     -> 1D series
% @Returns: ci    -> confidence interval based on 97.5% of the signal
%           mu    -> mean of 'x'
         

SEM = std(x)/sqrt(length(x));               % Standard Error
ts = tinv([0.025  0.975],length(x)-1);      % T-Score
ci = mean(x) + ts*SEM;                      % Confidence Intervals
mu = mean(x);                               % Mean

end

