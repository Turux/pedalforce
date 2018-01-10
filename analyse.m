close all
clear all
clc

wbdata = wbimport;
rawdata = rawimport;
maintable = buildtimetable(rawdata, 500, 0.17);
revtable = buildrevstable(maintable);
timetable = buildtimeblocktable(maintable,500,15);
angtable = buildangletable(maintable);
summary = buildsummary(revtable,wbdata);

clearvars rawdata;

figure
subplot(3,1,1)
plot(maintable.PowerW)
hold on
plot(maintable.PowerFiltW)
hold off
title('Power(W) over samples')
subplot(3,1,2)
plot(revtable.PowerW)
title('Power(W) over revolutions')
subplot(3,1,3)
plot(timetable.PowerW)
title('Power(W) every 15 sec')

figure
subplot(2,1,1)
polarplot(maintable.AngleRad, maintable.PowerW)
title('Power(W) distribution over time')
subplot(2,1,2)
polarplot(angtable.AngleSectorRad,angtable.PowerW)
title('Power(W) distribution mean')

figure
subplot(2,1,1)
polarplot(angtable.AngleSectorRad,angtable.ForceEffLeft)
title('Force Effectiveness Left')
subplot(2,1,2)
polarplot(angtable.AngleSectorRad,angtable.ForceEffRight)
title('Force Effectiveness Right')

[ newpower, diff, ci, mu ] = crossc( wbdata.PowerW, revtable.PowerFiltW );
newcadence = crossc( wbdata.Cadencerpm, revtable.CadenceRPM );

figure
subplot(3,1,1)
plot(newpower)
hold on
plot(wbdata.PowerW)
hold off
title('Power(W)')
subplot(3,1,2)
plot(wbdata.Cadencerpm)
hold on
plot(revtable.CadenceRPM)
hold off
title('Cadence(RPM)')
subplot(3,1,3)
plot(wbdata.Heartratebpm)
title('Heart Rate (BPM)')