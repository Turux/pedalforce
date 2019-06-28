close all
clear
clc

folder_result = uigetdir('/','Where is the data?');
D = dir(folder_result);
folder_save = uigetdir('/','Where do you want to save the results?');
if (exist(fullfile(folder_save,'Overall'),'dir') == 7)
    delete(fullfile(folder_save,'Overall','summary.mat'));
end
for k = 4:length(D) % avoid using the first ones
    currD = D(k).name; % Get the current subdirectory name
    folder_data=fullfile(folder_result,currD);
    fprintf('Processing participant %d of %d\n',k-3,length(D)-3)
    wbdata = wbimport(folder_data);
    rawdata = rawimport(folder_data);
    maintable = buildtimetable(rawdata, 500, 0.17);
    if exist(fullfile(folder_data,'error.mat'),'file')
        load(fullfile(folder_data,'error.mat'))
    else
        check = figure;
        ax1 = subplot(3,1,1);
        plot(maintable.Revolution,maintable.CadenceRPM)
        hold on
        plot(maintable.Revolution,maintable.CadenceFiltRPM)
        hold off
        legend('Original','Filtered')
        ylabel('Cadence(RPM)')
        ax2 = subplot(3,1,3);
        plot(maintable.Revolution,maintable.PowerW)
        hold on
        plot(maintable.Revolution,maintable.PowerFiltW)
        hold off
        ylabel('Power(W)')
        ax3 = subplot(3,1,2);
        plot(maintable.Revolution,maintable.TorqueNm)
        hold on
        plot(maintable.Revolution,maintable.TorqueFiltNm)
        hold off
        ylabel('Torque(Nm)')
        xlabel('Revolution')
        linkaxes([ax1,ax2 ax3],'x')
        prompt = 'What range of revolution needs to be delated? ';
        error = input(prompt);
        close(check)
        save(fullfile(folder_data,'error.mat'),'error')
    end
    maintable  = deleterevolution(maintable, error, 500, 0.17);
    revtable = buildrevstable(maintable);
    timetable = buildtimeblocktable(maintable,500,15);
    angtable = buildangletable(maintable);
    
    [~, ~, ~, ~, ~, diff ] = crossc( wbdata.TorqueNm, revtable.TorqueNm);
    if (diff<0)
        b=1+abs(diff);
        from=find(maintable.Revolution==b,1);
        l=(length(wbdata.TorqueNm)+1);
        to=find(maintable.Revolution==(b+l-2),1);
        revtable_short=revtable(b:l,:);
        maintable_short=maintable(from:to,:);
    end


    clearvars rawdata error ax1 ax2 ax3 prompt check diff from to b l; 

    [filepath,name] = fileparts(folder_data);
    if (exist(fullfile(folder_save,name),'dir') == 0)
        mkdir(folder_save,name);
    end
    save(fullfile(folder_save,name,['PART' name '.mat']),'maintable',...
        'revtable','timetable','angtable','wbdata','maintable_short','revtable_short')

    if (exist(fullfile(folder_save,'Overall'),'dir') == 0)
        mkdir(folder_save,'Overall');
        summary = buildsummary(revtable,wbdata,angtable,maintable,name);
        save(fullfile(folder_save,'Overall','summary.mat'),'summary')
    else
        if (exist(fullfile(folder_save,'Overall','summary.mat'),'file') == 2)
            load(fullfile(folder_save,'Overall','summary.mat'))
            summaryadd = buildsummary(revtable,wbdata,angtable,maintable,name);
            summary = [summary;summaryadd];
            save(fullfile(folder_save,'Overall','summary.mat'),'summary')
        else
            summary = buildsummary(revtable,wbdata,angtable,maintable,name);
            save(fullfile(folder_save,'Overall','summary.mat'),'summary')
        end

        clearvars summaryadd;
    end

    clearvars filepath folder_data folder_name name ;
end

% if(exist(fullfile(folder_save,'Overall','Rresults.mat'),'file') == 2)
%     load(fullfile(folder_save,'Overall','Rresults.mat'))
%     Rresults = struct2table(Rresults);
%     summary = [summary,Rresults];
%     save(fullfile(folder_save,'Overall','summary.mat'),'summary')
% end

clearvars folder_result folder_save k D currD;