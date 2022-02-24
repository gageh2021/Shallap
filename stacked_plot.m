function [] = stacked_plot(elements,element_ratios,core,period,title)

%% inputs:
% elements: A an array of the single elements to be analyzed, using element short forms. Must be placed in quotation marks with
% first letter capitalized. Elements should be separated with a comma and
% placed in square brackets.
% element2: A an array of the element ratios to be analyzed, using element short forms, with a slash between the elements. 
% Must be placed in quotation marks with first letter capitalized. Element ratios should be separated with a comma and
% placed in square brackets.
% core: The core number in quotation marks.
% period: The period of the moving average trendline, entered as an
% integer.
% title [optional]: Figure title, in quotation marks. Will be included in
% the plot and the filename.
%
%% outputs:
% .png file of one or more figures uploaded to figs folder.
%
%
%% usage example: xrf_data('Si','Ti','1',10) - where
% 'Si' is the numerator in the element ratio to be analyzed, 'Ti' is the
% denominator in the element ratiot to be analyzed, '1' is the core number,
% and 10 is the period of the moving average.
% 
% Created by Henry Gage, February 24, 2022.

repo_path = fileparts(mfilename('fullpath'));

if ~exist('elements','var')
     % third parameter does not exist, so default it to something
      elements = N/A;
end

if ~exist('element_ratios','var')
     % third parameter does not exist, so default it to something
      element_ratios = N/A;
end

if ~exist('title','var')
     % third parameter does not exist, so default it to something
      title = ""
end

if strcmpi((elements),'N/A') == 1 & strcmpi((element_ratios),'N/A') == 1
    error("Please enter element names or element ratios.")
elseif strcmpi((elements),'N/A') == 1 & strcmpi((element_ratios),'N/A') == 0
    if strcmpi((core),'all')
        for i=[1,2,5]
            T = readtable(fullfile(repo_path, 'data', sprintf("SGL-0%d_XRF.csv",i)));
            T_data = table();
            distance = table2array(T(:,1));
            T_data(:,1) = table(distance);
            y=1;
            for k=1:1:length(element_ratios)
                y=y+1;
                element1=extractBefore(element_ratios(k),"/");
                element2=extractAfter(element_ratios(k),"/");
                var2_num = strcat('v',element1);
                var2_array = strcat(var2_num,"_array");
                var2_data = strcat(var2_num,"_data");
                var2_ratio = strcat(var2_num,"_ratio");
                var3_num = strcat('v',element2);
                var3_array = strcat(var3_num,"_array");
                var2_trendline = strcat(var2_num,"_trendline");
                variable.(var2_num) = find(strcmpi(T.Properties.VariableNames,element1));
                variable.(var2_array) = table2array(T(:,variable.(var2_num)));
                variable.(var3_num) = find(strcmpi(T.Properties.VariableNames,element2));
                variable.(var3_array) = table2array(T(:,variable.(var3_num)));
                variable.(var2_ratio) = variable.(var2_array)./variable.(var3_array);
                variable.(var2_data) = [distance,variable.(var2_ratio)];
                variable.(var2_trendline) = movavg(variable.(var2_data),"simple",period);
                T_data(:,y)=table(variable.(var2_ratio)); 
            end
            fig1 = figure; clf;
            stackedplot(T_data,'XVariable',1,"Title",title,"DisplayLabels",element_ratios,"XLabel","Distance (mm)");
            filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("SGL_0%d-stacked-" + title,i));
            print(filename, '-dpng')
        end
    else
        for i=str2num(core)
            T = readtable(fullfile(repo_path, 'data', sprintf("SGL-0%d_XRF.csv",i)));
            T_data = table();
            distance = table2array(T(:,1));
            T_data(:,1) = table(distance);
            y=1;
            for k=1:1:length(element_ratios)
                y=y+1;
                element1=extractBefore(element_ratios(k),"/");
                element2=extractAfter(element_ratios(k),"/");
                var2_num = strcat('v',element1);
                var2_array = strcat(var2_num,"_array");
                var2_data = strcat(var2_num,"_data");
                var2_ratio = strcat(var2_num,"_ratio");
                var3_num = strcat('v',element2);
                var3_array = strcat(var3_num,"_array");
                var2_trendline = strcat(var2_num,"_trendline");
                variable.(var2_num) = find(strcmpi(T.Properties.VariableNames,element1));
                variable.(var2_array) = table2array(T(:,variable.(var2_num)));
                variable.(var3_num) = find(strcmpi(T.Properties.VariableNames,element2));
                variable.(var3_array) = table2array(T(:,variable.(var3_num)));
                variable.(var2_ratio) = variable.(var2_array)./variable.(var3_array);
                variable.(var2_data) = [distance,variable.(var2_ratio)];
                variable.(var2_trendline) = movavg(variable.(var2_data),"simple",period);
                T_data(:,y)=table(variable.(var2_ratio)); 
            end
            fig1 = figure; clf;
            stackedplot(T_data,'XVariable',1,"Title",title,"DisplayLabels",element_ratios,"XLabel","Distance (mm)");
            filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("SGL_0%d-stacked-" + title,i));
            print(filename, '-dpng')
        end
    end
elseif strcmpi((elements),'N/A') == 0 & strcmpi((element_ratios),'N/A') == 1
    if strcmpi((core),'all')
        for i=[1,2,5]
            T = readtable(fullfile(repo_path, 'data', sprintf("SGL-0%d_XRF.csv",i)));
            T_data = table();
            distance = table2array(T(:,1));
            T_data(:,1) = table(distance);
            y=1;
            for k=1:1:length(elements)
                y=y+1;
                var2_num = strcat('v',elements(k));
                var2_array = strcat(var2_num,"_array");
                var2_data = strcat(var2_num,"_data");
                var2_trendline = strcat(var2_num,"_trendline");
                variable.(var2_num) = find(strcmpi(T.Properties.VariableNames,elements(k)));
                variable.(var2_array) = table2array(T(:,variable.(var2_num)));
                variable.(var2_data) = [distance,variable.(var2_array)];
                variable.(var2_trendline) = movavg(variable.(var2_data),"simple",period);
                T_data(:,y)=table(variable.(var2_array)); 
            end
            fig1 = figure; clf;
            stackedplot(T_data,'XVariable',1,"Title",title,"DisplayLabels",elements,"XLabel","Distance (mm)");
            filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("SGL_0%d-stacked-" + title,i));
            print(filename, '-dpng')
        end
    else 
        for i=str2num(core)
            T = readtable(fullfile(repo_path, 'data', sprintf("SGL-0%d_XRF.csv",i)));
            T_data = table();
            distance = table2array(T(:,1));
            T_data(:,1) = table(distance);
            y=1;
            for k=1:1:length(elements)
                y=y+1;
                var2_num = strcat('v',elements(k));
                var2_array = strcat(var2_num,"_array");
                var2_data = strcat(var2_num,"_data");
                var2_trendline = strcat(var2_num,"_trendline");
                variable.(var2_num) = find(strcmpi(T.Properties.VariableNames,elements(k)));
                variable.(var2_array) = table2array(T(:,variable.(var2_num)));
                variable.(var2_data) = [distance,variable.(var2_array)];
                variable.(var2_trendline) = movavg(variable.(var2_data),"simple",period);
                T_data(:,y)=table(variable.(var2_array)); 
            end
            fig1 = figure; clf;
            stackedplot(T_data,'XVariable',1,"Title",title,"DisplayLabels",elements,"XLabel","Distance (mm)");
            filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("SGL_0%d-stacked-" + title,i));
            print(filename, '-dpng')
        end
    end
else
    if strcmpi((core),'all')
        for i=[1,2,5]
            T = readtable(fullfile(repo_path, 'data', sprintf("SGL-0%d_XRF.csv",i)));
            T_data = table();
            distance = table2array(T(:,1));
            T_data(:,1) = table(distance);
            y=1;
            varnames=[elements,element_ratios];
            for k=1:1:length(elements)
                y=y+1;
                var2_num = strcat('v',elements(k));
                var2_array = strcat(var2_num,"_array");
                var2_data = strcat(var2_num,"_data");
                var2_trendline = strcat(var2_num,"_trendline");
                variable.(var2_num) = find(strcmpi(T.Properties.VariableNames,elements(k)));
                variable.(var2_array) = table2array(T(:,variable.(var2_num)));
                variable.(var2_data) = [distance,variable.(var2_array)];
                variable.(var2_trendline) = movavg(variable.(var2_data),"simple",period);
                T_data(:,y)=table(variable.(var2_array)); 
            end
            for k=1:1:length(element_ratios)
                y=y+1;
                element1=extractBefore(element_ratios(k),"/");
                element2=extractAfter(element_ratios(k),"/");
                var2_num = strcat('v',element1);
                var2_array = strcat(var2_num,"_array");
                var2_data = strcat(var2_num,"_data");
                var2_ratio = strcat(var2_num,"_ratio");
                var3_num = strcat('v',element2);
                var3_array = strcat(var3_num,"_array");
                var2_trendline = strcat(var2_num,"_trendline");
                variable.(var2_num) = find(strcmpi(T.Properties.VariableNames,element1));
                variable.(var2_array) = table2array(T(:,variable.(var2_num)));
                variable.(var3_num) = find(strcmpi(T.Properties.VariableNames,element2));
                variable.(var3_array) = table2array(T(:,variable.(var3_num)));
                variable.(var2_ratio) = variable.(var2_array)./variable.(var3_array);
                variable.(var2_data) = [distance,variable.(var2_ratio)];
                variable.(var2_trendline) = movavg(variable.(var2_data),"simple",period);
                T_data(:,y)=table(variable.(var2_ratio)); 
            end
        end
            fig1 = figure; clf;
            stackedplot(T_data,'XVariable',1,"Title",title,"DisplayLabels",varnames,"XLabel","Distance (mm)");
            filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("SGL_0%d-stacked-" + title,i));
            print(filename, '-dpng')
    else
        for i = str2num(core)
            T = readtable(fullfile(repo_path, 'data', sprintf("SGL-0%d_XRF.csv",i)));
            T_data = table();
            distance = table2array(T(:,1));
            T_data(:,1) = table(distance);
            y=1;
            varnames=[elements,element_ratios];
            for k=1:1:length(elements)
                y=y+1;
                var2_num = strcat('v',elements(k));
                var2_array = strcat(var2_num,"_array");
                var2_data = strcat(var2_num,"_data");
                var2_trendline = strcat(var2_num,"_trendline");
                variable.(var2_num) = find(strcmpi(T.Properties.VariableNames,elements(k)));
                variable.(var2_array) = table2array(T(:,variable.(var2_num)));
                variable.(var2_data) = [distance,variable.(var2_array)];
                variable.(var2_trendline) = movavg(variable.(var2_data),"simple",period);
                T_data(:,y)=table(variable.(var2_array)); 
            end
            for k=1:1:length(element_ratios)
                y=y+1;
                element1=extractBefore(element_ratios(k),"/");
                element2=extractAfter(element_ratios(k),"/");
                var2_num = strcat('v',element1);
                var2_array = strcat(var2_num,"_array");
                var2_data = strcat(var2_num,"_data");
                var2_ratio = strcat(var2_num,"_ratio");
                var3_num = strcat('v',element2);
                var3_array = strcat(var3_num,"_array");
                var2_trendline = strcat(var2_num,"_trendline");
                variable.(var2_num) = find(strcmpi(T.Properties.VariableNames,element1));
                variable.(var2_array) = table2array(T(:,variable.(var2_num)));
                variable.(var3_num) = find(strcmpi(T.Properties.VariableNames,element2));
                variable.(var3_array) = table2array(T(:,variable.(var3_num)));
                variable.(var2_ratio) = variable.(var2_array)./variable.(var3_array);
                variable.(var2_data) = [distance,variable.(var2_ratio)];
                variable.(var2_trendline) = movavg(variable.(var2_data),"simple",period);
                T_data(:,y)=table(variable.(var2_ratio)); 
            end
        end
        fig1 = figure; clf;
        stackedplot(T_data,'XVariable',1,"Title",title,"DisplayLabels",varnames,"XLabel","Distance (mm)");
        filename = fullfile(repo_path, 'figs', sprintf('SGL-0%d',i), sprintf("SGL_0%d-stacked-" + title,i));
        print(filename, '-dpng')
    end    
end
