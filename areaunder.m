function [ WOri, WFull, WMissing, AreaError, Efficiency, EfficiencyError ] = areaunder( angtable )
%AREAUNDER Summary of this function goes here
%   Detailed explanation goes here

Full = max(angtable.PowerW)*ones(size(angtable.AngleSectorRad));
Missing=Full-angtable.PowerW;
WOri = trapz(angtable.AngleSectorRad,angtable.PowerW);
WMissing = trapz(angtable.AngleSectorRad,Missing);
WFull = trapz(angtable.AngleSectorRad,Full);
W120 = trapz(angtable.AngleSectorRad,angtable.PowerW*1.2);
W190 = trapz(angtable.AngleSectorRad,angtable.PowerW*1.9);
W275 = trapz(angtable.AngleSectorRad,angtable.PowerW*2.75);
W300 = trapz(angtable.AngleSectorRad,angtable.PowerW*3);

Efficiency = (WOri/WFull)*100;

AreaError = sqrt(((angtable.PowerWSD)./angtable.PowerW).^2+(std(angtable.AngleSectorRad)./angtable.AngleSectorRad).^2);
AreaError = sum(AreaError.^2);
AreaError = sqrt(AreaError);
EfficiencyError = sqrt((AreaError/WOri).^2+(AreaError/WFull).^2);
EfficiencyError = EfficiencyError*Efficiency;

end

