function [ revstable ] = buildrevstable( timetable )
%BUILDREVSTABLE Summary of this function goes here
%   Detailed explanation goes here

revstable = table(unique(timetable.Revolution),'VariableNames', {'Revolution'});
%revstable.Cadence = splitapply(@mean,timetable.CadenceRPM,timetable.Revolution);
revstable.CadenceRPM =splitapply(@mean,timetable.CadenceFiltRPM,timetable.Revolution);
revstable.PowerW = splitapply(@mean,timetable.PowerW,timetable.Revolution);
revstable.PowerFiltW = splitapply(@mean,timetable.PowerFiltW,timetable.Revolution);
revstable.Balance = splitapply(@mean,timetable.BalanceLR,timetable.Revolution);
revstable.MaxCadenceRPM = splitapply(@max,timetable.CadenceFiltRPM,timetable.Revolution);
revstable.MinCadenceRPM = splitapply(@min,timetable.CadenceFiltRPM,timetable.Revolution);
revstable.TorqueNm = splitapply(@mean,timetable.TorqueNm,timetable.Revolution);
revstable.MaxPowerW = splitapply(@max,timetable.PowerFiltW,timetable.Revolution);
revstable.MinPowerW = splitapply(@min,timetable.PowerFiltW,timetable.Revolution);
revstable.ForceEffLeft = splitapply(@mean,timetable.ForceEffLeft,timetable.Revolution);
revstable.ForceEffRight = splitapply(@mean,timetable.ForceEffRight,timetable.Revolution);
revstable.ResForceLeftAngleDeg = splitapply(@mean,timetable.ResForceLeftAngleDeg,timetable.Revolution);
revstable.ResForceRightAngleDeg = splitapply(@mean,timetable.ResForceRightAngleDeg,timetable.Revolution);
end

