function [] = xrf_data(element1,element2,core,period)

%% inputs:
% element1: The acronym for the element to be analyzed, or the numerator in the
% element ratio to be analyzed. Must be placed in quotation marks with
% first letter capitalized.
% element2: The acronym for the denominator in the element ratio to be
% analyzed. Must be placed in quotation marks with first letter capitalized. If only one element is to be analyzed, use "N/A".
% Core: The core number in quotation marks.
% Period: The period of the moving average trendline, entered as an
% integer.
%
%% outputs:
% .png file of a figure uploaded to Figures folder.
%
%
%% usage example: xrf_data('Si','Ti','1',10) - where
% 'Si' is the numerator in the element ratio to be analyzed, 'Ti' is the
% denominator in the element ratiot to be analyzed, '1' is the core number,
% and 10 is the period of the moving average.
% 
% Created by Henry Gage, February 12, 2022.

repo_path = fileparts(mfilename('fullpath'));

if strcmpi((core),'all')
    for i=[1,2,5]
        T = readtable(fullfile(repo_path, 'data', sprintf("SGL-0%d_XRF.csv",i)));
            if strcmpi((element2),"N/A")==1
                E1_number = find(strcmpi(T.Properties.VariableNames,element1));
                E1 = table2array(T(:,E1_number));
                distance = table2array(T(:,1));
                data = [distance,E1];
                trendline=movmean(data,period,'omitnan');
                fig1 = figure; clf;
                plot(distance,E1,'b.-'); hold on;
                plot(trendline(:,1),trendline(:,2),"r-","LineWidth",2);
                title({sprintf('Core SGL-0%d,',i)+element1},'FontSize',10);%Add a title
                ylabel(element1+" (cps)"); % Add a y-axis label.
                xlabel("Distance (mm)"); % Add an x-axis label.
                legend('Raw Data',sprintf('%d-Point Moving Average',period)); hold off; % Add a legend.
                filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("S_GL0%d-" + element1,i));
                print(filename, '-dpng')
            else
                E1_number = find(strcmpi(T.Properties.VariableNames,element1));
                E2_number = find(strcmpi(T.Properties.VariableNames,element2));
                E1 = table2array(T(:,E1_number));
                E2 = table2array(T(:,E2_number));
                ratio = E1./E2;
                distance = table2array(T(:,1));
                data = [distance,ratio];
                trendline=movmean(data,period,'omitnan');
                fig1 = figure; clf;
                plot(distance,ratio,'b.-'); hold on;
                plot(trendline(:,1),trendline(:,2),"r-","LineWidth",2);
                title({'Core SGL-0' i ', ' element1 "/" element2},'FontSize',10); %Add a title
                ylabel(element1+"/"+element2+" Ratio"); % Add a y-axis label.
                xlabel('Distance (mm)'); % Add an x-axis label.
                legend('Raw Data',sprintf('%d-Point Moving Average',period)); % Add a legend.
                filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("SGL_0%d-" + element1 +"-"+element2,i));
                print(filename, '-dpng')
            end
    end
else
    for i=str2num(core)
        T = readtable(fullfile(repo_path, 'data', sprintf("SGL-0%d_XRF.csv",i)));
        if strcmpi((element2),"N/A")==1
            E1_number = find(strcmpi(T.Properties.VariableNames,element1));
            E1 = table2array(T(:,E1_number));
            distance = table2array(T(:,1));
            data = [distance,E1];
            trendline=movmean(data,period,'omitnan');
            fig1 = figure; clf;
            plot(distance,E1,'b.-'); hold on;
            plot(trendline(:,1),trendline(:,2),"r-","LineWidth",2);
            title({sprintf('Core SGL-0%d,',i)+element1},'FontSize',10);%Add a title
            ylabel(element1+" (cps)"); % Add a y-axis label.
            xlabel("Distance (mm)"); % Add an x-axis label.
            legend('Raw Data',sprintf('%d-Point Moving Average',period)); hold off; % Add a legend.
            filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("SGL_0%d-" + element1,i));
            print(filename, '-dpng')
        else
            E1_number = find(strcmpi(T.Properties.VariableNames,element1));
            E2_number = find(strcmpi(T.Properties.VariableNames,element2));
            E1 = table2array(T(:,E1_number));
            E2 = table2array(T(:,E2_number));
            ratio = E1./E2;
            distance = table2array(T(:,1));
            data = [distance,ratio];
            trendline=movmean(data,period,'omitnan');
            fig1 = figure; clf;
            plot(distance,ratio,'b.-'); hold on;
            plot(trendline(:,1),trendline(:,2),"r-","LineWidth",2);
            title({'Core SGL-0' i ', ' element1 "/" element2},'FontSize',10); %Add a title
            ylabel(element1+"/"+element2+" Ratio"); % Add a y-axis label.
            xlabel('Distance (mm)'); % Add an x-axis label.
            legend('Raw Data',sprintf('%d-Point Moving Average',period)); % Add a legend.
            filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("SGL_0%d-" + element1 +"-"+element2,i));
            print(filename, '-dpng')
        end
    end
end