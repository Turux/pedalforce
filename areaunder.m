function [ AreaUPower, AreaUPowerError, AreaUMissing, AreaUMissingError,...
    EfficiencyMinPower, EfficiencyMinPowerError,...
    PowerAbove200, PowerAbove200Error,...
    InefficientSectorPercentage, InefficientSectorPercentageError ] = areaunder( angtable )
%AREAUNDER Summary of this function goes here
%   Detailed explanation goes here

Power200 = 200*ones(size(angtable.AngleSectorRad));
PowerU200 = angtable.PowerW;
PowerU200(PowerU200>200) = 200;
MissingPower = Power200-PowerU200;
AreaUPower = trapz(angtable.AngleSectorRad,angtable.PowerW);
AreaUPowerError = areaerror(angtable.PowerW,angtable.PowerWSD,angtable.AngleSectorRad,2.5);
AreaUPowerU200 = trapz(angtable.AngleSectorRad,PowerU200);
AreaUPowerU200Error = areaerror(PowerU200,angtable.PowerWSD,angtable.AngleSectorRad,2.5);
AreaU200 = trapz(angtable.AngleSectorRad,Power200);
AreaU200Error = areaerror(Power200,angtable.PowerWSD,angtable.AngleSectorRad,2.5);
AreaUMissing = trapz(angtable.AngleSectorRad,MissingPower);
AreaUMissingError = areaerror(AreaUMissing,angtable.PowerWSD,angtable.AngleSectorRad,2.5);
EfficiencyMinPower = (AreaUPowerU200/AreaU200)*100;
EfficiencyMinPowerError = sqrt((AreaUPowerU200Error/AreaUPowerU200).^2+(AreaU200Error/AreaU200).^2);
EfficiencyMinPowerError = EfficiencyMinPowerError*EfficiencyMinPower;
PowerAbove200 = 100-((AreaUPowerU200/AreaUPower)*100);
PowerAbove200Error = sqrt((AreaUPowerU200Error/AreaUPowerU200).^2+(AreaUPowerError/AreaUPower).^2);
PowerAbove200Error = PowerAbove200Error * PowerAbove200;
InefficientSector = sum(angtable.PowerW<200)*5;
InefficientSectorError = 2.5;
InefficientSectorPercentage = (InefficientSector/360)*100;
InefficientSectorPercentageError = sqrt((2.5/InefficientSector).^2+(2.5/360).^2);
InefficientSectorPercentageError = InefficientSectorPercentageError * InefficientSectorPercentage;
% Full = max(angtable.PowerW)*ones(size(angtable.AngleSectorRad));
% Missing=Full-angtable.PowerW;
% 
% WMissing = trapz(angtable.AngleSectorRad,Missing);
% WFull = trapz(angtable.AngleSectorRad,Full);
% W120 = trapz(angtable.AngleSectorRad,angtable.PowerW*1.2);
% W190 = trapz(angtable.AngleSectorRad,angtable.PowerW*1.9);
% W275 = trapz(angtable.AngleSectorRad,angtable.PowerW*2.75);
% W300 = trapz(angtable.AngleSectorRad,angtable.PowerW*3);
% 
% Efficiency = (WOri/WFull)*100;
% 
% AreaError = sqrt(((angtable.PowerWSD)./angtable.PowerW).^2+(std(angtable.AngleSectorRad)./angtable.AngleSectorRad).^2);
% AreaError = sum(AreaError.^2);
% AreaError = sqrt(AreaError);
% EfficiencyError = sqrt((AreaError/WOri).^2+(AreaError/WFull).^2);
% EfficiencyError = EfficiencyError*Efficiency;

end

