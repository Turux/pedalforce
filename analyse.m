close all
clear all
clc

wbdata = wbimport;
rawdata = rawimport;
maintable = buildtimetable(rawdata, 500, 0.17);
check = figure;
ax1 = subplot(2,1,1);
plot(maintable.Revolution,maintable.CadenceRPM)
hold on
plot(maintable.Revolution,maintable.CadenceFiltRPM)
hold off
ax2 = subplot(2,1,2);
plot(maintable.Revolution,maintable.PowerW)
hold on
plot(maintable.Revolution,maintable.PowerFiltW)
hold off
linkaxes([ax1,ax2],'x')
prompt = 'What range of revolution needs to be delated? ';
x = input(prompt);
close(check)
maintable  = deleterevolution(maintable, x, 500, 0.17);
revtable = buildrevstable(maintable);
timetable = buildtimeblocktable(maintable,500,15);
angtable = buildangletable(maintable);
summary = buildsummary(revtable,wbdata);

clearvars rawdata x ax1 ax2;

figure
subplot(2,1,1)
polarplot(maintable.AngleRad, maintable.PowerW)
title('Power(W) distribution over time')
subplot(2,1,2)
polarplot(angtable.AngleSectorRad,angtable.PowerW)
title('Power(W) distribution mean')

figure
subplot(2,2,1)
polarplot(angtable.AngleSectorRad,angtable.ForceEffLeft)
title('Force Effectiveness Left')
subplot(2,2,2)
polarplot(angtable.AngleSectorRad,angtable.ForceEffRight)
title('Force Effectiveness Right')
subplot(2,2,3)
polarplot(maintable.AngleRad,maintable.RadForceLeftN)
title('Radial Force Left(N)')
subplot(2,2,4)
polarplot(maintable.AngleRad,maintable.RadForceRightN)
title('Radial Force Right(N)')


figure
subplot(2,1,1)
polarplot(angtable.AngleSectorRad,angtable.PowerW)
Full = max(angtable.PowerW)*ones(size(angtable.AngleSectorRad));
Missing=Full-angtable.PowerW;
hold on
polarplot(angtable.AngleSectorRad,Full)
polarplot(angtable.AngleSectorRad,Missing)
hold off

WOri = trapz(angtable.AngleSectorRad,angtable.PowerW);
WMissing = trapz(angtable.AngleSectorRad,Missing);
WFull = trapz(angtable.AngleSectorRad,Full);
W120 = trapz(angtable.AngleSectorRad,angtable.PowerW*1.2);
W190 = trapz(angtable.AngleSectorRad,angtable.PowerW*1.9);
W275 = trapz(angtable.AngleSectorRad,angtable.PowerW*2.75);
W300 = trapz(angtable.AngleSectorRad,angtable.PowerW*3);

y = [WOri WMissing WFull W120 W190 W275 W300];
c = categorical({'Original','Missing','FullCircle','120%','190%','275%','300%'});
subplot(2,1,2)
bar(c,y)

clearvars Full Missing x y WOri WMissing WFull W120 W190 W275 W300

[ newpower, diff, ci, mu ] = crossc( wbdata.PowerW, revtable.PowerFiltW );
newcadence = crossc( wbdata.Cadencerpm, revtable.CadenceRPM );

figure
ax1 = subplot(3,1,1);
plot(newpower)
hold on
plot(wbdata.PowerW)
hold off
title('Power(W)')
legend('Pedals','WattBike')
ax2 = subplot(3,1,2);
plot(wbdata.Cadencerpm)
hold on
plot(revtable.CadenceRPM)
hold off
title('Cadence(RPM)')
ax3 = subplot(3,1,3);
plot(wbdata.Heartratebpm)
title('Heart Rate (BPM)')
linkaxes([ax1,ax2,ax3],'x')

clearvars newpower diff