function [ AreaUTorque, AreaUTorqueError, AreaUMissing, AreaUMissingError,...
    EfficiencyMinTorque, EfficiencyMinTorqueError,...
    TorqueAbove20, TorqueAbove20Error,...
    InefficientSectorPercentage, InefficientSectorPercentageError ] = areaunder( angtable )
%AREAUNDER Summary of this function goes here
%   Detailed explanation goes 

Torque20 = 200*ones(size(angtable.AngleSectorRad));
TorqueU20 = angtable.TorqueNm;
TorqueU20(TorqueU20>20) = 20;
MissingTorque = Torque20-TorqueU20;
AreaUTorque = trapz(angtable.AngleSectorRad,angtable.TorqueNm);
AreaUTorqueError = areaerror(angtable.TorqueNm,angtable.TorqueNmSD,angtable.AngleSectorRad,2.5);
AreaUTorqueU20 = trapz(angtable.AngleSectorRad,TorqueU20);
AreaUTorqueU20Error = areaerror(TorqueU20,angtable.TorqueNmSD,angtable.AngleSectorRad,2.5);
AreaU20 = trapz(angtable.AngleSectorRad,Torque20);
AreaU20Error = areaerror(Torque20,angtable.TorqueNmSD,angtable.AngleSectorRad,2.5);
AreaUMissing = trapz(angtable.AngleSectorRad,MissingTorque);
AreaUMissingError = areaerror(AreaUMissing,angtable.TorqueNmSD,angtable.AngleSectorRad,2.5);
EfficiencyMinTorque = (AreaUTorqueU20/AreaU20)*100;
EfficiencyMinTorqueError = sqrt((AreaUTorqueU20Error/AreaUTorqueU20).^2+(AreaU20Error/AreaU20).^2);
EfficiencyMinTorqueError = EfficiencyMinTorqueError*EfficiencyMinTorque;
TorqueAbove20 = 100-((AreaUTorqueU20/AreaUTorque)*100);
TorqueAbove20Error = sqrt((AreaUTorqueU20Error/AreaUTorqueU20).^2+(AreaUTorqueError/AreaUTorque).^2);
TorqueAbove20Error = TorqueAbove20Error * TorqueAbove20;
if (TorqueAbove20 < 0)
    TorqueAbove20 = 0;
    TorqueAbove20Error = 0;
end 
InefficientSector = sum(angtable.PowerW<200)*5;
InefficientSectorError = 2.5;
InefficientSectorPercentage = (InefficientSector/360)*100;
InefficientSectorPercentageError = sqrt((2.5/InefficientSector).^2+(2.5/360).^2);
InefficientSectorPercentageError = InefficientSectorPercentageError * InefficientSectorPercentage;

end

