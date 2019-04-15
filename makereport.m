close all
clear
clc

folder_result = uigetdir('/','Please select the result folder');
D = dir(folder_result);
nString=D(length(D)-1).name;
n=str2double(nString);
load(fullfile(folder_result,'Overall','summary.mat'));
[FileName,PathName] = uigetfile('*.csv','Select the questionnaire result');
info = importquestionnaire(fullfile(PathName,FileName));
clearvars D filename FileName nString PathName 
for id = 1:n
    idString = num2str(id,'%02d');
    filename = dir(fullfile(folder_result,idString,'*.mat'));
    load(fullfile(folder_result,idString,filename.name));
    [a1,a2,a3,a4,a5] = angletabletime(maintable_short);
    clearvars kString filename
    newname = sprintf('%sReport',idString);
    options = struct('format','html','showCode',false);
    reportFile=publish('report.m',options);
    movefile('html',newname);
    close all
    clearvars AngMaxTorque AngMinTorque ax1 ax2 MaxTorque...
        MaxTorquePosition MinTorque MinTorquePosition neg pos newname reportFile
end