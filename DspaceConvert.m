%medload - Function for importing data from a med file, from scratch
function [timenum,file,data] = medload2(filename)

%% Parse Filename Data
[path,file,~]=fileparts(filename);

%% Timestamp Data
% Initialize timestamp variables.
delimiter = ' ';
fileID = fopen(filename,'r');
startRow = 3;
endRow = 3;
formatSpec = '%*s%s%s%s%s%*s%*s%*s%*s%*s%*s%[^\n\r]';
% Read timestamp data
dateArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
% Allocate imported timestamp array to column variable names
month = dateArray{:, 1};
day = dateArray{:, 2};
year = dateArray{:, 3};
time = dateArray{:, 4};
date = strcat(month,{' '},day,{' '},year,{' '},time);
timenum = datenum(date,'mmm dd, yyyy HH:MM:SS.FFF');
% Clear temporary timestamp variables
clearvars startRow endRow formatSpec dateArray ans;
frewind(fileID)

%% Energy Calibration Data
% Initialize calibration variables.
startRow = 8;
endRow = 11;
formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
% Read calibration data.
dataArray1 = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow-1, 'ReturnOnError', false);
% Allocate imported calibration array to column variable names
D1Cal = dataArray1{:, 1};
D2Cal = dataArray1{:, 2};
D3Cal = dataArray1{:, 3};
D4Cal = dataArray1{:, 4};
D5Cal = dataArray1{:, 5};
D6Cal = dataArray1{:, 6};
D7Cal = dataArray1{:, 7};
D8Cal = dataArray1{:, 8};
D9Cal = dataArray1{:, 9};
D10Cal = dataArray1{:, 10};
% Clear temporary calibration variables
clearvars startRow endRow formatSpec dataArray1 ans;
frewind(fileID)

%% X-Ray Diffraction Data
% Initialize diffraction data variables.
formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';
% Determine number of header rows
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
% Read diffraction data
dataArray2 = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
% Allocate imported diffraction array to column variable names
D1Data = dataArray2{:, 1};
D2Data = dataArray2{:, 2};
D3Data = dataArray2{:, 3};
D4Data = dataArray2{:, 4};
D5Data = dataArray2{:, 5};
D6Data = dataArray2{:, 6};
D7Data = dataArray2{:, 7};
D8Data = dataArray2{:, 8};
D9Data = dataArray2{:, 9};
D10Data = dataArray2{:, 10};
% Close the text file and clear temporary variables
fclose(fileID);
clearvars filename delimiter startRow formatSpec fileID dataArray2 ans;

%% Data Conversion
% Normalize Intensities
D1DataN = D1Data/max(D1Data);
D2DataN = D2Data/max(D2Data);
D3DataN = D3Data/max(D3Data);
D4DataN = D4Data/max(D4Data);
D5DataN = D5Data/max(D5Data);
D6DataN = D6Data/max(D6Data);
D7DataN = D7Data/max(D7Data);
D8DataN = D8Data/max(D8Data);
D9DataN = D9Data/max(D9Data);
D10DataN = D10Data/max(D10Data);
% Constants
chan=(0:2047)';
E2L=12.39841;
% Energy Calculations
D1Energy=chan*(D1Cal(3)^2)+chan*D1Cal(2)+D1Cal(1);
D2Energy=chan*(D2Cal(3)^2)+chan*D2Cal(2)+D2Cal(1);
D3Energy=chan*(D3Cal(3)^2)+chan*D3Cal(2)+D3Cal(1);
D4Energy=chan*(D4Cal(3)^2)+chan*D4Cal(2)+D4Cal(1);
D5Energy=chan*(D5Cal(3)^2)+chan*D5Cal(2)+D5Cal(1);
D6Energy=chan*(D6Cal(3)^2)+chan*D6Cal(2)+D6Cal(1);
D7Energy=chan*(D7Cal(3)^2)+chan*D7Cal(2)+D7Cal(1);
D8Energy=chan*(D8Cal(3)^2)+chan*D8Cal(2)+D8Cal(1);
D9Energy=chan*(D9Cal(3)^2)+chan*D9Cal(2)+D9Cal(1);
D10Energy=chan*(D10Cal(3)^2)+chan*D10Cal(2)+D10Cal(1);
% D-Spacing Calculations
D1DSpc=(E2L./D1Energy)/(2*sin((0.5*D1Cal(4))*pi/180));
D2DSpc=(E2L./D2Energy)/(2*sin((0.5*D2Cal(4))*pi/180));
D3DSpc=(E2L./D3Energy)/(2*sin((0.5*D3Cal(4))*pi/180));
D4DSpc=(E2L./D4Energy)/(2*sin((0.5*D4Cal(4))*pi/180));
D5DSpc=(E2L./D5Energy)/(2*sin((0.5*D5Cal(4))*pi/180));
D6DSpc=(E2L./D6Energy)/(2*sin((0.5*D6Cal(4))*pi/180));
D7DSpc=(E2L./D7Energy)/(2*sin((0.5*D7Cal(4))*pi/180));
D8DSpc=(E2L./D8Energy)/(2*sin((0.5*D8Cal(4))*pi/180));
D9DSpc=(E2L./D9Energy)/(2*sin((0.5*D9Cal(4))*pi/180));
D10DSpc=(E2L./D10Energy)/(2*sin((0.5*D10Cal(4))*pi/180));

%% Write CSV file of d-spacings vs. normalized intensities for all detectors
data=table(D1DSpc,D1DataN,D2DSpc,D2DataN,D3DSpc,D3DataN,D4DSpc,D4DataN,D5DSpc,D5DataN,D6DSpc,D6DataN,D7DSpc,D7DataN,D8DSpc,D8DataN,D9DSpc,D9DataN,D10DSpc,D10DataN);
textname=strcat(path,{'\'},file,{'.txt'});
writetable(data,textname{1});