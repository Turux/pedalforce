function [ timetable ] = buildtimetable( rawtable,fs,arm )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

timetable = table(rawtable.angle, 'VariableNames', {'AngleDeg'});
%timetable.AngleDeg = timetable.AngleDeg + 90;
%timetable.AngleDeg = wrapTo360(timetable.AngleDeg);
timetable.AngleRad = deg2rad(timetable.AngleDeg);
[AngSec, AngG] = deg2G(timetable.AngleDeg);
timetable.AngleSector = AngSec;
timetable.AngleG = AngG;
timetable.Revolution = deg2revs(timetable.AngleDeg);
timetable.CadenceRads = rad2rads(timetable.AngleRad,fs);
timetable.CadenceRPM = deg2rpm(timetable.AngleDeg,fs);
timetable.CadenceFiltRads = movmean(timetable.CadenceRads, fs/2);
timetable.CadenceFiltRPM = movmean(timetable.CadenceRPM, fs/2);
timetable.TanForceLeftN = rawtable.Fe_l;
timetable.TanForceRightN = rawtable.Fe_r;
timetable.RadForceLeftN = rawtable.Fu_l;
timetable.RadForceRightN = rawtable.Fu_r;
timetable.NetTanForceN = timetable.TanForceLeftN + timetable.TanForceRightN;
timetable.TorqueNm = timetable.NetTanForceN.*arm;
timetable.TorqueLeftNm = timetable.TanForceLeftN.*arm;
timetable.TorqueRightNm = timetable.TanForceRightN.*arm;
timetable.TorqueFiltNm = movmean(timetable.TorqueNm,fs/2);
timetable.PowerW = timetable.TorqueNm.*timetable.CadenceFiltRads;
timetable.PowerLeftW = timetable.TorqueLeftNm.*timetable.CadenceFiltRads;
timetable.PowerRightW = timetable.TorqueRightNm.*timetable.CadenceFiltRads;
timetable.PowerFiltW = timetable.TorqueFiltNm.*timetable.CadenceFiltRads;
%timetable.BalanceLR = (abs(timetable.TanForceLeftN)./(abs(timetable.TanForceLeftN)+abs(timetable.TanForceRightN)))*100;
timetable.BalanceLR = (timetable.PowerLeftW./timetable.PowerW)*100;
totalforcemagleft = sqrt((timetable.TanForceLeftN.^2)+(timetable.RadForceLeftN.^2));
totalforcemagright = sqrt((timetable.TanForceRightN.^2)+(timetable.RadForceRightN.^2));
timetable.ForceEffLeft = (abs(timetable.TanForceLeftN)./(totalforcemagleft));
timetable.ForceEffRight = (abs(timetable.TanForceRightN)./(totalforcemagright));
timetable.ResForceLeftAngleDeg = atand(timetable.RadForceLeftN./timetable.TanForceLeftN);
timetable.ResForceRightAngleDeg = atand(timetable.RadForceRightN./timetable.TanForceRightN);

clearvars AngSec AngG totalforcemagleft totalforcemagright

end

