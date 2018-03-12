function [ summarytable ] = buildsummary( pedaltable, wbtable, name)
%SUMMARY Summary of this function goes here
%   Detailed explanation goes here

summarytable = table(str2double(name), 'VariableNames', {'Participant'});
summarytable.Power = mean(pedaltable.PowerW);
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
summarytable.BLR = mean(pedaltable.Balance);
summarytable.BLRSD = std(pedaltable.Balance);
summarytable.BLRWB = mean(wbtable.Leftlegpercent);
summarytable.BLRWBSD = std(wbtable.Leftlegpercent);
end