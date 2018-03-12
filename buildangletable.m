function [ output ] = buildangletable( timetable )
%BUILDANGLETABLE Summary of this function goes here
%   Detailed explanation goes here

output = table(unique(timetable.AngleSector),'VariableNames', {'AngleSectorDeg'});
output.AngleSectorRad = deg2rad(output.AngleSectorDeg);
output.CadenceRPM = splitapply(@mean,timetable.CadenceFiltRPM,timetable.AngleG);
output.CadenceRPMSD = splitapply(@std,timetable.CadenceFiltRPM,timetable.AngleG);
output.TorqueNm = splitapply(@mean,timetable.TorqueNm,timetable.AngleG);
output.TorqueNmSD = splitapply(@std,timetable.TorqueNm,timetable.AngleG);
output.PowerW = splitapply(@mean,timetable.PowerW,timetable.AngleG);
output.PowerWSD = splitapply(@std,timetable.PowerW,timetable.AngleG);
output.PowerLeftW = splitapply(@mean,timetable.PowerLeftW,timetable.AngleG);
output.PowerLeftWSD = splitapply(@std,timetable.PowerLeftW,timetable.AngleG);
output.PowerRightW = splitapply(@mean,timetable.PowerRightW,timetable.AngleG);
output.PowerRightWSD = splitapply(@std,timetable.PowerRightW,timetable.AngleG);
output.Balance = splitapply(@mean,timetable.BalanceLR,timetable.AngleG);
output.BalanceSD = splitapply(@std,timetable.BalanceLR,timetable.AngleG);
output.MaxCadenceRPM = splitapply(@max,timetable.CadenceFiltRPM,timetable.AngleG);
output.MinCadenceRPM = splitapply(@min,timetable.CadenceFiltRPM,timetable.AngleG);
output.MaxPowerW = splitapply(@max,timetable.PowerFiltW,timetable.AngleG);
output.MinPowerW = splitapply(@min,timetable.PowerFiltW,timetable.AngleG);
output.ForceEffLeft = splitapply(@nanmean,timetable.ForceEffLeft,timetable.AngleG);
output.ForceEffRight = splitapply(@nanmean,timetable.ForceEffRight,timetable.AngleG);
output.TanForceLeftN = splitapply(@nanmean,timetable.TanForceLeftN,timetable.AngleG);
output.TanForceRightN = splitapply(@nanmean,timetable.TanForceRightN,timetable.AngleG);
output.RadForceLeftN= splitapply(@nanmean,timetable.RadForceLeftN,timetable.AngleG);
output.RadForceRightN= splitapply(@nanmean,timetable.RadForceRightN,timetable.AngleG);
output.ResForceLeftAngleDeg = splitapply(@nanmean,timetable.ResForceLeftAngleDeg,timetable.AngleG);
output.ResForceRightAngleDeg = splitapply(@nanmean,timetable.ResForceRightAngleDeg,timetable.AngleG);

end

