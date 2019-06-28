%% Participants Info
fprintf('Participant ID: %02d',summary.Participant(id));
fprintf('\nGender: %s',char(info.Gender(id)));
fprintf('\nAge: %s',num2str(info.Age(id)));


%% General Results
% *Overall results for the entire test*

fprintf('Cadence: %.1f±%.1f RPM',summary.Cadence(id),summary.CadenceSEM(id));
fprintf('\nTorque: %.1f±%.1f Nm',summary.Torque(id),summary.TorqueSEM(id));
%%
% The overall power is obtained by $P=\tau\cdot\dot\theta$
%
fprintf('\nPower: %.1f±%.1f W',summary.Power(id),summary.PowerSEM(id));
%%
% The Normalised Power is instead: $NP=(avr(avr(P)^4))^{1/4}$
%
fprintf('\nNormalised Power: %.1f±%.1f W',summary.NormalisedPowerW(id),summary.NormalisedPowerWError(id));
%%
% *Analysis of the Torque shape*
%
%
figure;
polarplot(angtable.AngleSectorRad,angtable.TorqueNm);
title('Torque(Nm) by Angle(°)');

[MaxTorque, MaxTorquePosition]= max(angtable.TorqueNm);
AngMaxTorque = angtable.AngleSectorDeg(MaxTorquePosition);
fprintf('Max Torque: %.1f±%.1f Nm at angle %.1f±%.1f°',MaxTorque,...
    angtable.TorqueNmSD(MaxTorquePosition), AngMaxTorque,summary.AngError(id));
[MinTorque, MinTorquePosition]= min(angtable.TorqueNm);
AngMinTorque = angtable.AngleSectorDeg(MinTorquePosition);
fprintf('\nMin Torque: %.1f±%.1f Nm at angle %.1f±%.1f°',MinTorque,...
    angtable.TorqueNmSD(MinTorquePosition), AngMinTorque,summary.AngError(id));
fprintf('\nArea under the curve: %.1f±%.1f J',summary.AreaUTorque(id), summary.AreaUTorqueError(id))
fprintf('\nBalance Left to Right %.1f±%.1f %%',summary.Balance(id), summary.BalanceSEM(id));

figure;
ax1=subplot(2,1,1);
pos=maintable.TorqueLeftNm(40000:40500);
neg=pos;
pos(pos<0)=0;
neg(neg>0)=0;
area(neg,'FaceColor','r');
hold on
area(pos,'FaceColor','b');
hold off
title('Left Torque(Nm)');
ax2=subplot(2,1,2);
pos=maintable.TorqueRightNm(40000:40500);
neg=pos;
pos(pos<0)=0;
neg(neg>0)=0;
area(neg,'FaceColor','r');
hold on
area(pos,'FaceColor','b');
hold off
title('Right Torque(Nm)');
xlabel('s @ 500Hz')
linkaxes([ax1,ax2],'xy');
snapnow;

%%
%                               L      |       R
fprintf('\nFWHM:\t\t      %.1f±%.1f  |  %.1f±%.1f',...
    summary.FWHMLeft(id),summary.FWHMLeftSEM(id),summary.FWHMRight(id),summary.FWHMRightSEM(id));
fprintf('\nRise Time:\t   %.3f±%.3f S|  %.3f±%.3f S',...
    summary.RTLeftS(id),summary.RTLeftSSEM(id),summary.RTRightS(id),summary.RTRightSSEM(id));
fprintf('\nPedal Smoothness:     %.1f±%.1f %%|  %.1f±%.1f %%',...
    summary.PedalSmoothnessLeft(id),summary.PedalSmoothnessLeftSEM(id),...
    summary.PedalSmoothnessRight(id),summary.PedalSmoothnessRightSEM(id));
fprintf('\nTorque Effectiveness: %.1f±%.1f %%|  %.1f±%.1f %%',...
    summary.TorqueEffectivenessLeft(id),summary.TorqueEffectivenessLeftSEM(id),...
    summary.TorqueEffectivenessRight(id),summary.TorqueEffectivenessRightSEM(id));

%% 
% In this section the pedalling tecnique is analysed. The first two graphs
% will present the ratio between effective force and wasted force in an
% avarage pedal stroke. The closer the line is to '1' the more the force 
% applied is fully effective to aid the rotation; the closer is to '0' the
% more all your force applied is directed on a radial plane rathern than on
% a tangencial one.
figure;
polarplot(angtable.AngleSectorRad,angtable.ForceEffLeft);
title('Force Effectiveness Left');
figure;
polarplot(angtable.AngleSectorRad,angtable.ForceEffRight);
title('Force Effectiveness Right');
snapnow;
%%
% The next two graphs will present where you have wasted more force. This
% is the force directed perpendicularly to the crack arm rathern that
% tangencial to it. This force is wasted in either compressing the arm
% 'blue' or extending it 'red'.
figure;
ax1=polaraxes;
posL=maintable.RadForceLeftN;
negL=posL;
posL(posL<0)=NaN;
negL(negL>0)=NaN;
polarplot(maintable.AngleRad,abs(negL),'r');
hold on
polarplot(maintable.AngleRad,posL,'b');
hold off
title('Radial Force Left(N)');
rl1=rlim;
figure;
ax2=polaraxes;
posR=maintable.RadForceRightN;
negR=posR;
posR(posR<0)=NaN;
negR(negR>0)=NaN;
polarplot(maintable.AngleRad,abs(negR),'r');
hold on
polarplot(maintable.AngleRad,posR,'b');
hold off
title('Radial Force Right(N)');
syncr(ax1,ax2);
snapnow;
clearvars posL posR negL negR
%%
% The next two graph will help you understaning your peddaling tecnique:
% the reppresent the direction of the force applied to the pedals. The
% sector identified by a 'blue' line are the ones in which your force applied
% is aiding the rotation of the pedal and generating toque. The ones in
% which the clour is instead 'red' indicates a sector in which the force
% applied is hindering the rotation.
figure;
ax1=polaraxes;
posL=maintable.TanForceLeftN;
negL=posL;
posL(posL<0)=NaN;
negL(negL>0)=NaN;
polarplot(maintable.AngleRad,abs(negL),'r');
hold on
polarplot(maintable.AngleRad,posL,'b');
hold off
title('Tangential Force Left(N)');
figure;
ax2=polaraxes;
posR=maintable.TanForceRightN;
negR=posR;
posR(posR<0)=NaN;
negR(negR>0)=NaN;
polarplot(maintable.AngleRad,abs(negR),'r');
hold on
polarplot(maintable.AngleRad,posR,'b');
hold off
title('Tangential Force Right(N)');
syncr(ax1,ax2);
snapnow;

clearvars posL posR negL negR
%% Time analysis
% The next section shows the 


figure;
scatter3(revtable.TorqueNm, revtable.CadenceRPM, revtable.Revolution);
test = [revtable.TorqueNm revtable.CadenceRPM revtable.Revolution];
[idx,C] = kmeans(test,5);
C1 = sortrows(C,3);
hold on
plot3(C1(:,1),C1(:,2),C1(:,3),'LineWidth',5);
xlabel('Torque Nm');
ylabel('Cadence RPM');
zlabel('Revolutions #');
hold off
snapnow;

%% Fatigue Factor




