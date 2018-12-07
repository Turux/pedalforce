function [ output ] = buildangletable( timetable )
%BUILDANGLETABLE Summary of this function goes here
%   Detailed explanation goes here

output = table(unique(timetable.AngleSector),'VariableNames', {'AngleSectorDeg'});
output.AngleSectorRad = deg2rad(output.AngleSectorDeg);
output.CadenceRPM = splitapply(@mean,timetable.CadenceRPM,timetable.AngleG);
output.CadenceRPMSD = splitapply(@std,timetable.CadenceRPM,timetable.AngleG);
output.TorqueNm = splitapply(@mean,timetable.TorqueNm,timetable.AngleG);
output.TorqueLeftNm = splitapply(@mean,timetable.TorqueLeftNm,timetable.AngleG);
output.TorqueRightNm = splitapply(@mean,timetable.TorqueRightNm,timetable.AngleG);
output.TorqueNmSD = splitapply(@std,timetable.TorqueNm,timetable.AngleG);
output.PowerW = splitapply(@mean,timetable.PowerW,timetable.AngleG);
output.PowerWSD = splitapply(@std,timetable.PowerW,timetable.AngleG);
output.PowerLeftW = splitapply(@mean,timetable.PowerLeftW,timetable.AngleG);
output.PowerLeftWSD = splitapply(@std,timetable.PowerLeftW,timetable.AngleG);
output.PowerRightW = splitapply(@mean,timetable.PowerRightW,timetable.AngleG);
output.PowerRightWSD = splitapply(@std,timetable.PowerRightW,timetable.AngleG);
output.MaxCadenceRPM = splitapply(@max,timetable.CadenceFiltRPM,timetable.AngleG);
output.MinCadenceRPM = splitapply(@min,timetable.CadenceFiltRPM,timetable.AngleG);
output.MaxPowerW = splitapply(@max,timetable.PowerFiltW,timetable.AngleG);
output.MinPowerW = splitapply(@min,timetable.PowerFiltW,timetable.AngleG);
output.ForceEffLeft = splitapply(@nanmean,timetable.ForceEffLeft,timetable.AngleG);
output.ForceEffRight = splitapply(@nanmean,timetable.ForceEffRight,timetable.AngleG);
output.TanForceLeftN = splitapply(@nanmean,timetable.TanForceLeftN,timetable.AngleG);
output.TanForceLeftNSD = splitapply(@std,timetable.TanForceLeftN,timetable.AngleG);
output.TanForceRightN = splitapply(@nanmean,timetable.TanForceRightN,timetable.AngleG);
output.TanForceRightNSD = splitapply(@std,timetable.TanForceRightN,timetable.AngleG);
output.RadForceLeftN= splitapply(@nanmean,timetable.RadForceLeftN,timetable.AngleG);
output.RadForceLeftNSD= splitapply(@std,timetable.RadForceLeftN,timetable.AngleG);
output.RadForceRightN= splitapply(@nanmean,timetable.RadForceRightN,timetable.AngleG);
output.RadForceRightNSD= splitapply(@std,timetable.RadForceRightN,timetable.AngleG);
output.ResForceLeftAngleDeg = splitapply(@nanmean,timetable.ResForceLeftAngleDeg,timetable.AngleG);
output.ResForceRightAngleDeg = splitapply(@nanmean,timetable.ResForceRightAngleDeg,timetable.AngleG);
output.BalanceLR = (output.TorqueLeftNm./output.TorqueNm).*100;


end




