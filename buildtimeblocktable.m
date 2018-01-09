function [ output ] = buildtimeblocktable( timetable,fs,s )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

cadence = splitbytime(@mean,timetable.CadenceFiltRPM,fs,s);
output = table(cadence, 'VariableNames', {'CadenceRPM'});
output.TorqueNm = splitbytime(@mean,timetable.TorqueNm,fs,s);
output.PowerW = splitbytime(@mean,timetable.PowerW,fs,s);
output.Balance = splitbytime(@mean,timetable.BalanceLR,fs,s);
output.MaxCadenceRPM = splitbytime(@max,timetable.CadenceRPM,fs,s);
output.MinCadenceRPM = splitbytime(@min,timetable.CadenceRPM,fs,s);
output.MaxPowerW = splitbytime(@max,timetable.PowerW,fs,s);
output.MinPowerW = splitbytime(@min,timetable.PowerW,fs,s);
output.ForceEffLeft = splitbytime(@mean,timetable.ForceEffLeft,fs,s);
output.ForceEffRight = splitbytime(@mean,timetable.ForceEffRight,fs,s);

clearvars cadence
end

