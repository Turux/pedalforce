function [ WOri, WFull, WMissing, AreaError, Efficency, EfficencyError ] = areaunder( angtable )
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

Efficency = (WOri/WFull)*100;

AreaError = sqrt((mean(angtable.PowerWSD)).^2+(0.0872665).^2);
EfficencyError = sqrt((AreaError/WOri).^2+(AreaError/WFull).^2);

end

