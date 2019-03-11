close all
clear
clc

[FileName,PathName] = uigetfile('*.mat','Select the MATLAB save file');

load (fullfile(PathName,FileName))

clearvars FileName PathName

figure
subplot(2,1,1);
polarplot(maintable.AngleRad, maintable.PowerW);
title('Power(W) distribution over time')
subplot(2,1,2);
polarplot(angtable.AngleSectorRad,angtable.PowerW);
title('Power(W) distribution mean')

figure
subplot(2,2,1)
polarplot(angtable.AngleSectorRad,angtable.ForceEffLeft)
title('Force Effectiveness Left')
subplot(2,2,2)
polarplot(angtable.AngleSectorRad,angtable.ForceEffRight)
title('Force Effectiveness Right')
subplot(2,2,3)
posL=maintable.RadForceLeftN;
negL=posL;
posL(posL<0)=NaN;
negL(negL>0)=NaN;
polarplot(maintable.AngleRad,abs(negL))
hold on
polarplot(maintable.AngleRad,posL)
hold off
title('Radial Force Left(N)')
subplot(2,2,4)
posR=maintable.RadForceRightN;
negR=posR;
posR(posR<0)=NaN;
negR(negR>0)=NaN;
polarplot(maintable.AngleRad,abs(negR))
hold on
polarplot(maintable.AngleRad,posR)
hold off
title('Radial Force Right(N)')

clearvars posL posR negL negR

figure
subplot(2,1,1)
posL=maintable.TanForceLeftN;
negL=posL;
posL(posL<0)=NaN;
negL(negL>0)=NaN;
polarplot(maintable.AngleRad,abs(negL))
hold on
polarplot(maintable.AngleRad,posL)
hold off
title('Tangential Force Left(N)')
subplot(2,1,2)
posR=maintable.TanForceRightN;
negR=posR;
posR(posR<0)=NaN;
negR(negR>0)=NaN;
polarplot(maintable.AngleRad,abs(negR))
hold on
polarplot(maintable.AngleRad,posR)
hold off
title('Tangential Force Right(N)')

clearvars posL posR negL negR

figure
subplot(2,1,1)
polarplot(angtable.AngleSectorRad,angtable.PowerW)
title('Power (W) Efficiency by Angle (deg)')
Full = max(angtable.PowerW)*ones(size(angtable.AngleSectorRad));
Missing=Full-angtable.PowerW;
hold on
polarplot(angtable.AngleSectorRad,Full)
polarplot(angtable.AngleSectorRad,Missing)
hold off
legend('Input Power','FullCircle','Missing Power')

WOri = trapz(angtable.AngleSectorRad,angtable.PowerW);
WMissing = trapz(angtable.AngleSectorRad,Missing);
WFull = trapz(angtable.AngleSectorRad,Full);
W120 = trapz(angtable.AngleSectorRad,angtable.PowerW*1.2);
W190 = trapz(angtable.AngleSectorRad,angtable.PowerW*1.9);
W275 = trapz(angtable.AngleSectorRad,angtable.PowerW*2.75);
W300 = trapz(angtable.AngleSectorRad,angtable.PowerW*3);

Efficency = (WOri/WFull)*100;

y = [WOri WMissing WFull W120 W190 W275 W300];
c = categorical({'Original','Missing','FullCircle','120%','190%','275%','300%'});
subplot(2,1,2)
bar(c,y);
ylabel('Energy (J)')
title('Area under the curve')

clearvars Full Missing c y WOri WMissing WFull W120 W190 W275 W300

[ newpower, diff, ci, mu ] = crossc( wbdata.PowerW, revtable.PowerW );
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
plot(newcadence)
hold off
title('Cadence(RPM)')
ax3 = subplot(3,1,3);
plot(wbdata.Heartratebpm)
title('Heart Rate (BPM)')
linkaxes([ax1,ax2,ax3],'x')

clearvars newpower newcadence ax1 ax2 ax3

figure
scatter3(revtable.TorqueNm, revtable.CadenceRPM, revtable.Revolution)
test = [revtable.TorqueNm revtable.CadenceRPM revtable.Revolution];
[idx,C] = kmeans(test,5);
C1 = sortrows(C,3);
hold on
plot3(C1(:,1),C1(:,2),C1(:,3),'LineWidth',5)
hold off
test = [revtable.TorqueNm revtable.CadenceRPM];
[idx,C, sumdist, dist] = kmeans(test,1);
Spread = mean(dist);

clearvars test idx C sumdist dist

figure
Y = fft(maintable.NetTanForceN);
Fs = 500;
T = 1/Fs;
L = length(maintable.TorqueNm);
t = (0:L-1)*T;
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

clearvars Y Fs T L t P1 P2 f