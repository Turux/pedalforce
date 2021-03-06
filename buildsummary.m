function [ summarytable ] = buildsummary( pedaltable, wbtable, angtable, name)
%SUMMARY Summary of this function goes here
%   Detailed explanation goes here

summarytable = table(str2double(name), 'VariableNames', {'Participant'});
summarytable.Power = mean(pedaltable.PowerW);
summarytable.PowerSEM = sem(pedaltable.PowerW);
%summarytable.PowerSD = std(pedaltable.PowerW);
summarytable.PowerWB = mean(wbtable.PowerW);
%summarytable.PowerWBSD = std(wbtable.PowerW);
summarytable.PowerWBSEM = sem(wbtable.PowerW);
summarytable.Cadence = mean(pedaltable.CadenceRPM);
%summarytable.CadenceSD = std(pedaltable.CadenceRPM);
summarytable.CadenceSEM = sem(pedaltable.CadenceRPM);
summarytable.CadenceWB = mean(wbtable.Cadencerpm);
%summarytable.CadenceWBSD = std(wbtable.Cadencerpm);
summarytable.CadenceWEBSEM = sem(wbtable.Cadencerpm);
summarytable.Torque = mean(pedaltable.TorqueNm);
%summarytable.TorqueSD = std(pedaltable.TorqueNm);
summarytable.TorqueSEM = sem(pedaltable.TorqueNm);
summarytable.TorqueWB = mean(wbtable.TorqueNm);
summarytable.TorqueWBSEM = sem(wbtable.TorqueNm);
summarytable.HeartRate = mean(wbtable.Heartratebpm);
%summarytable.HeartRateSD = std(wbtable.Heartratebpm);
summarytable.HeartRateSEM = sem(wbtable.Heartratebpm);
summarytable.Balance = mean(pedaltable.Balance);
%summarytable.BalanceSD = std(pedaltable.Balance);
summarytable.BalanceSEM = sem(pedaltable.Balance);
summarytable.BalanceWB = mean(wbtable.Leftlegpercent);
%summarytable.BalanceWBSD = std(wbtable.Leftlegpercent);
summarytable.BalanceWBSEM = sem(wbtable.Leftlegpercent);
summarytable.FWHMLeft = mean(pedaltable.FWHMLeft);
summarytable.FWHMLeftSEM = sem(pedaltable.FWHMLeft);
summarytable.FWHMRight = mean(pedaltable.FWHMRight);
summarytable.FWHMRightSEM = sem(pedaltable.FWHMRight);
summarytable.RTLeftS = mean(pedaltable.RTLeft);
summarytable.RTLeftSSEM = sem(pedaltable.RTLeft);
summarytable.RTRightS = mean(pedaltable.RTRight);
summarytable.RTRightSSEM = sem(pedaltable.RTRight);
summarytable.PedalSmoothnessLeft = mean(pedaltable.PedalSmoothnessLeft);
summarytable.PedalSmoothnessLeftSEM = sem(pedaltable.PedalSmoothnessLeft);
summarytable.PedalSmoothnessRight = mean(pedaltable.PedalSmoothnessRight);
summarytable.PedalSmoothnessRightSEM = sem(pedaltable.PedalSmoothnessRight);
summarytable.TorqueEffectivenessLeft = mean(pedaltable.TorqueEffectivenessLeft);
summarytable.TorqueEffectivenessLeftSEM = sem(pedaltable.TorqueEffectivenessLeft);
summarytable.TorqueEffectivenessRight = mean(pedaltable.TorqueEffectivenessRight);
summarytable.TorqueEffectivenessRightSEM = sem(pedaltable.TorqueEffectivenessRight);
[ fwhmLeft, ~ ] = fwrt( angtable.PowerLeftW );
[ fwhmRight, ~ ] = fwrt( angtable.PowerRightW );
summarytable.FWHMLeftDeg = fwhmLeft.*5;
summarytable.FWHMRightDeg = fwhmRight.*5;
[ psLeft,teLeft ] = pste( angtable.PowerLeftW );
[ psRight,teRight ] = pste( angtable.PowerRightW );
summarytable.PedalSmoothnessAngLeft = psLeft;
summarytable.PedalSmoothnessAngRight = psRight;
summarytable.TorqueEffectivenessAngLeft = teLeft;
summarytable.TorqueEffectivenessAngRight = teRight;

[ AreaUTorque, AreaUTorqueError, ...
    AreaUMissing, AreaUMissingError,...
    EfficiencyMinTorque, EfficiencyMinTorqueError,...
    TorqueAbove20, TorqueAbove20Error,...
    InefficientSectorPercentage, InefficientSectorPercentageError ] = areaunder(angtable);

summarytable.AreaUTorque = AreaUTorque;
summarytable.AreaUTorqueError = AreaUTorqueError;
summarytable.AreaUMissing = AreaUMissing;
summarytable.AreaUMissingError = AreaUMissingError;
summarytable.EfficiencyMinTorque = EfficiencyMinTorque;
summarytable.EfficiencyMinTorqueError = EfficiencyMinTorqueError;
summarytable.TorqueAbove20 = TorqueAbove20;
summarytable.TorqueAbove20Error = TorqueAbove20Error;
summarytable.InefficientSectorPercentage = InefficientSectorPercentage;
summarytable.InefficientSectorPercentageError = InefficientSectorPercentageError;

[~,locs,widths,proms] = findpeaks(angtable.PowerW,angtable.AngleSectorDeg,'SortStr','descend','WidthReference','halfheight');

summarytable.Widthhalfheight = widths(1);
summarytable.Prominance = proms(1);
summarytable.AngMaxPower = locs(1);

[~,locs] = findpeaks(-angtable.PowerW,angtable.AngleSectorDeg,'SortStr','descend');

summarytable.AngMinPower = locs(1);
summarytable.AngError = 2.5;

[pks,locs] = findpeaks(abs(angtable.RadForceLeftN),angtable.AngleSectorDeg,'SortStr','descend');

summarytable.MaxWastedForceLeft = pks(1);
summarytable.MaxWastefForceLeftError = mean(angtable.RadForceLeftNSD);
summarytable.MaxWastedForceLeftAngle = locs(1);

[pks,locs] = findpeaks(abs(angtable.RadForceRightN),angtable.AngleSectorDeg,'SortStr','descend');

summarytable.MaxWastedForceRight = pks(1);
summarytable.MaxWastefForceRightError = mean(angtable.RadForceRightNSD);
summarytable.MaxWastedForceRightAngle = locs(1);

[pks, locs] = max([abs(angtable.TanForceLeftN),angtable.AngleSectorDeg]);

summarytable.MaxFroceLeft = pks(1);
summarytable.MaxForceLeftError = mean(angtable.TanForceLeftNSD);
summarytable.MaxForceLeftAng = angtable.AngleSectorDeg(locs(1));

[pks, locs] = max([abs(angtable.TanForceRightN),angtable.AngleSectorDeg]);

summarytable.MaxForceRight = pks(1);
summarytable.MaxForceRightError = mean(angtable.TanForceRightNSD);
summarytable.MaxForceRightAng = angtable.AngleSectorDeg(locs(1));
summarytable.PowerSpread = mean(angtable.PowerWSD);


clearvars AreaUPower AreaUPowerError locs widths proms pks ...
    AreaUMissing AreaUMissingError EfficiencyMinPower EfficiencyMinPowerError ...
    PowerAbove200 PowerAbove200Error InefficientSectorPercentage ...
    InefficientSectorPercentageError fwhmLeft fwhmRight psLeft psRight teLeft teRight

end