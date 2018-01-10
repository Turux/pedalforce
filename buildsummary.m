function [ summarytable ] = buildsummary( pedaltable, wbtable )
%SUMMARY Summary of this function goes here
%   Detailed explanation goes here

summarytable = table(mean(pedaltable.PowerW), 'VariableNames', {'Power'});
summarytable.PowerSD = std(pedaltable.PowerW);
summarytable.PowerWB = mean(wbtable.PowerW);
summarytable.PowerWBSD = std(wbtable.PowerW);
summarytable.Cadence = mean(pedaltable.CadenceRPM);
summarytable.CadenceSD = std(pedaltable.CadenceRPM);
summarytable.CadenceWB = mean(wbtable.Cadencerpm);
summarytable.CadenceWBSD = std(wbtable.Cadencerpm);
summarytable.Torque = mean(pedaltable.TorqueNm);
summarytable.TorqueSD = std(pedaltable.TorqueNm);
summarytable.HR = mean(wbtable.Heartratebpm);
summarytable.HRSD = std(wbtable.Heartratebpm);

end
