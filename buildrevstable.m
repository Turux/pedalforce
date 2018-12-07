function [ revstable ] = buildrevstable( timetable )
%BUILDREVSTABLE Summary of this function goes here
%   Detailed explanation goes here

revstable = table(unique(timetable.Revolution),'VariableNames', {'Revolution'});
revstable.CadenceRads = splitapply(@mean,timetable.CadenceRads,timetable.Revolution);
revstable.CadenceRPM =splitapply(@mean,timetable.CadenceFiltRPM,timetable.Revolution);
revstable.TorqueNm = splitapply(@mean,timetable.TorqueNm,timetable.Revolution);
revstable.TorqueLeftNm = splitapply(@mean,timetable.TorqueLeftNm,timetable.Revolution);
revstable.TorqueRightNm = splitapply(@mean,timetable.TorqueRightNm,timetable.Revolution);
revstable.PowerW = revstable.TorqueNm.*revstable.CadenceRads;
revstable.PowerLeftW = revstable.TorqueLeftNm.*revstable.CadenceRPM;
revstable.PowerLeftWSD = splitapply(@std,timetable.PowerLeftW,timetable.Revolution);
revstable.PowerRightW = revstable.TorqueRightNm.*revstable.CadenceRPM;
revstable.PowerRightWSD = splitapply(@std,timetable.PowerRightW,timetable.Revolution);
revstable.BalanceLR = (revstable.TorqueLeftNm./revstable.TorqueNm).*100;
revstable.MaxCadenceRPM = splitapply(@max,timetable.CadenceFiltRPM,timetable.Revolution);
revstable.MinCadenceRPM = splitapply(@min,timetable.CadenceFiltRPM,timetable.Revolution);
revstable.MaxPowerW = splitapply(@max,timetable.PowerFiltW,timetable.Revolution);
revstable.MinPowerW = splitapply(@min,timetable.PowerFiltW,timetable.Revolution);
revstable.ForceEffLeft = splitapply(@mean,timetable.ForceEffLeft,timetable.Revolution);
revstable.ForceEffRight = splitapply(@mean,timetable.ForceEffRight,timetable.Revolution);
revstable.ResForceLeftAngleDeg = splitapply(@mean,timetable.ResForceLeftAngleDeg,timetable.Revolution);
revstable.ResForceRightAngleDeg = splitapply(@mean,timetable.ResForceRightAngleDeg,timetable.Revolution);
[ fwhmLeft, rtLeft ] = splitapply(@fwrt,timetable.PowerLeftW,timetable.Revolution);
[ fwhmRight, rtRight ] = splitapply(@fwrt,timetable.PowerRightW,timetable.Revolution);
revstable.FWHMLeft = fwhmLeft;
revstable.RTLeft = rtLeft;
revstable.FWHMRight = fwhmRight;
revstable.RTRight = rtRight;
[ psLeft,teLeft ] = splitapply(@pste,timetable.PowerLeftW,timetable.Revolution);
[ psRight,teRight ] = splitapply(@pste,timetable.PowerRightW,timetable.Revolution);
revstable.PedalSmoothnessLeft = psLeft;
revstable.TorqueEffectivenessLeft = teLeft;
revstable.PedalSmoothnessRight = psRight;
revstable.TorqueEffectivenessRight = teRight;

clearvars fwhmLeft fwhmRight rtLeft rtRight psLeft psRight teLeft teRight

end

