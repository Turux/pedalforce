function [ newtimetable ] = deleterevolution( timetable, num, fs,arm )
%DELETEREVOLUTION Summary of this function goes here
%   Detailed explanation goes here

newtimetable = timetable;
%if isempty(num)
%    return 
%end
for i = 1:length(num)
    toDelete = newtimetable.Revolution == num(i);
    newtimetable(toDelete,:) = [];
end
newtimetable.Revolution = deg2revs(newtimetable.AngleDeg);
newtimetable.CadenceRads = rad2rads(newtimetable.AngleRad,fs);
newtimetable.CadenceRPM = deg2rpm(newtimetable.AngleDeg,fs);
newtimetable.CadenceFiltRads = movmean(newtimetable.CadenceRads, fs/2);
newtimetable.CadenceFiltRPM = movmean(newtimetable.CadenceRPM, fs/2);
newtimetable.NetTanForceN = newtimetable.TanForceLeftN + newtimetable.TanForceRightN;
newtimetable.TorqueNm = newtimetable.NetTanForceN.*arm;
newtimetable.TorqueFiltNm = movmean(newtimetable.TorqueNm,fs/2);
newtimetable.PowerW = newtimetable.TorqueNm.*newtimetable.CadenceFiltRads;
newtimetable.PowerFiltW = newtimetable.TorqueFiltNm.*newtimetable.CadenceFiltRads;
newtimetable.BalanceLR = (abs(newtimetable.TanForceLeftN)./(abs(newtimetable.TanForceLeftN)+abs(newtimetable.TanForceRightN)))*100;
totalforcemagleft = sqrt((newtimetable.TanForceLeftN.^2)+(newtimetable.RadForceLeftN.^2));
totalforcemagright = sqrt((newtimetable.TanForceRightN.^2)+(newtimetable.RadForceRightN.^2));
newtimetable.ForceEffLeft = (abs(newtimetable.TanForceLeftN)./(totalforcemagleft));
newtimetable.ForceEffRight = (abs(newtimetable.TanForceRightN)./(totalforcemagright));
newtimetable.ResForceLeftAngleDeg = atand(newtimetable.RadForceLeftN./newtimetable.TanForceLeftN);
newtimetable.ResForceRightAngleDeg = atand(newtimetable.RadForceRightN./newtimetable.TanForceRightN);

clearvars AngSec AngG totalforcemagleft totalforcemagright

end

