function [ output ] = buildangletable( timetable )
%BUILDANGLETABLE Summary of this function goes here
%   Detailed explanation goes here

output = table(unique(timetable.AngleSector),'VariableNames', {'AngleSectorDeg'});
output.AngleSectorRad = deg2rad(output.AngleSectorDeg);
output.CadenceRPM =splitapply(@mean,timetable.CadenceFiltRPM,timetable.AngleG);
output.PowerW = splitapply(@mean,timetable.PowerW,timetable.AngleG);
output.Balance = splitapply(@mean,timetable.BalanceLR,timetable.AngleG);
output.MaxCadenceRPM = splitapply(@max,timetable.CadenceFiltRPM,timetable.AngleG);
output.MinCadenceRPM = splitapply(@min,timetable.CadenceFiltRPM,timetable.AngleG);
output.MaxPowerW = splitapply(@max,timetable.PowerFiltW,timetable.AngleG);
output.MinPowerW = splitapply(@min,timetable.PowerFiltW,timetable.AngleG);
output.ForceEffLeft = splitapply(@mean,timetable.ForceEffLeft,timetable.AngleG);
output.ForceEffRight = splitapply(@mean,timetable.ForceEffRight,timetable.AngleG);
output.ResForceLeftAngleDeg = splitapply(@mean,timetable.ResForceLeftAngleDeg,timetable.AngleG);
output.ResForceRightAngleDeg = splitapply(@mean,timetable.ResForceRightAngleDeg,timetable.AngleG);

end

