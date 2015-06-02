%% Import data from med file.
% Script for importing data from an med file, based on:
%
%    D:\Data\NSLS\X17B2\Fay_66\FAY__066_0004.med

%% Initialize variables.
filename = 'D:\Data\NSLS\X17B2\Fay_66\FAY__066_0002.med';
delimiter = ' ';
startRow = 8;
endRow = 11;

%% Format string for each line of text:
%   columnX: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this code. 
dataArray1 = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Allocate imported array to column variable names
F66D1Cal = dataArray1{:, 1};
F66D2Cal = dataArray1{:, 2};
F66D3Cal = dataArray1{:, 3};
F66D4Cal = dataArray1{:, 4};
F66D5Cal = dataArray1{:, 5};
F66D6Cal = dataArray1{:, 6};
F66D7Cal = dataArray1{:, 7};
F66D8Cal = dataArray1{:, 8};
F66D9Cal = dataArray1{:, 9};
F66D10Cal = dataArray1{:, 10};

%% Clear temporary variables
clearvars filename delimiter startRow endRow formatSpec fileID dataArray1 ans;

%% Initialize variables.
filename = 'D:\Data\NSLS\X17B2\Fay_66\FAY__066_0002.med';
delimiter = ' ';
%%startRow = 78;

%% Format string for each line of text:
%   columnX: double (%f)
formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

tline = fgetl(fileID);
n = 0;
startRow = 0;
while ischar(tline);
   n = n + 1;
   if strcmp(tline,'DATA: ');
       startRow = n + 1;
   end
   tline = fgetl(fileID);
end
frewind(fileID);

%% Read columns of data according to format string.
dataArray2 = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Allocate imported array to column variable names
F66D1Data = dataArray2{:, 1};
F66D2Data = dataArray2{:, 2};
F66D3Data = dataArray2{:, 3};
F66D4Data = dataArray2{:, 4};
F66D5Data = dataArray2{:, 5};
F66D6Data = dataArray2{:, 6};
F66D7Data = dataArray2{:, 7};
F66D8Data = dataArray2{:, 8};
F66D9Data = dataArray2{:, 9};
F66D10Data = dataArray2{:, 10};

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray2 ans;

%% Normalize Intensities
F66D1DataN = F66D1Data/max(F66D1Data);
F66D2DataN = F66D2Data/max(F66D2Data);
F66D3DataN = F66D3Data/max(F66D3Data);
F66D4DataN = F66D4Data/max(F66D4Data);
F66D5DataN = F66D5Data/max(F66D5Data);
F66D6DataN = F66D6Data/max(F66D6Data);
F66D7DataN = F66D7Data/max(F66D7Data);
F66D8DataN = F66D8Data/max(F66D8Data);
F66D9DataN = F66D9Data/max(F66D9Data);
F66D10DataN = F66D10Data/max(F66D10Data);

%% Calculate D-Spacings
% Constants
chan=(0:2047)';
E2L=12.39841;
% Energy Calculations
F66D1Energy=chan*(F66D1Cal(3)^2)+chan*F66D1Cal(2)+F66D1Cal(1);
F66D2Energy=chan*(F66D2Cal(3)^2)+chan*F66D2Cal(2)+F66D2Cal(1);
F66D3Energy=chan*(F66D3Cal(3)^2)+chan*F66D3Cal(2)+F66D3Cal(1);
F66D4Energy=chan*(F66D4Cal(3)^2)+chan*F66D4Cal(2)+F66D4Cal(1);
F66D5Energy=chan*(F66D5Cal(3)^2)+chan*F66D5Cal(2)+F66D5Cal(1);
F66D6Energy=chan*(F66D6Cal(3)^2)+chan*F66D6Cal(2)+F66D6Cal(1);
F66D7Energy=chan*(F66D7Cal(3)^2)+chan*F66D7Cal(2)+F66D7Cal(1);
F66D8Energy=chan*(F66D8Cal(3)^2)+chan*F66D8Cal(2)+F66D8Cal(1);
F66D9Energy=chan*(F66D9Cal(3)^2)+chan*F66D9Cal(2)+F66D9Cal(1);
F66D10Energy=chan*(F66D10Cal(3)^2)+chan*F66D10Cal(2)+F66D10Cal(1);
% D-Spacing Calculations
F66D1DSpc=(E2L./F66D1Energy)/(2*sin((0.5*F66D1Cal(4))*pi/180));
F66D2DSpc=(E2L./F66D2Energy)/(2*sin((0.5*F66D2Cal(4))*pi/180));
F66D3DSpc=(E2L./F66D3Energy)/(2*sin((0.5*F66D3Cal(4))*pi/180));
F66D4DSpc=(E2L./F66D4Energy)/(2*sin((0.5*F66D4Cal(4))*pi/180));
F66D5DSpc=(E2L./F66D5Energy)/(2*sin((0.5*F66D5Cal(4))*pi/180));
F66D6DSpc=(E2L./F66D6Energy)/(2*sin((0.5*F66D6Cal(4))*pi/180));
F66D7DSpc=(E2L./F66D7Energy)/(2*sin((0.5*F66D7Cal(4))*pi/180));
F66D8DSpc=(E2L./F66D8Energy)/(2*sin((0.5*F66D8Cal(4))*pi/180));
F66D9DSpc=(E2L./F66D9Energy)/(2*sin((0.5*F66D9Cal(4))*pi/180));
F66D10DSpc=(E2L./F66D10Energy)/(2*sin((0.5*F66D10Cal(4))*pi/180));

%% Plot Detector 9 Data
% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'YTickLabel',{'','','','','','','','','','',''},'YTick',[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1],'XTick',[1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6],'XMinorTick','on','XDir','reverse','LineWidth',1);
xlim(axes1,[1 3.6]);
box(axes1,'on');
hold(axes1,'all');

% Create plot
plot(F66D7DSpc,F66D7DataN,F65D7DSpc,F65D7DataN,F63D7DSpc,F63D7DataN,F64D7DSpc,F64D7DataN,'LineWidth',1.5)
title('Fe-Rich Olivine X-Ray Diffraction Comparison','FontWeight','bold','FontSize',12);
xlabel('d-spacing (Å)','FontWeight','bold');
ylabel('Intensity (arb. units)','FontWeight','bold');
legend('Fa40','Fa60','Fa80','Fa100','Location','Best')
