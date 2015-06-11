% readMED - Function for reading raw data from a med file.
% Last updated: June 11, 2015
% Code written by Matthew L. Whitaker
function readMED(filename)

%% Parse Filename Data
[path,file,~]=fileparts(which(filename));
% Make path and file available in base workspace
assignin('base', 'file', file);
assignin('base', 'path', path);

%% Timestamp Data
% Initialize timestamp variables.
delimiter = ' ';
fileID = fopen(filename,'r');
startRow = 3;
endRow = 3;
formatSpec = '%*s%s%s%s%s%*s%*s%*s%*s%*s%*s%*[^\n\r]';
% Read timestamp data
dateArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
% Allocate imported timestamp array to column variable names
month = dateArray{:, 1};
day = dateArray{:, 2};
year = dateArray{:, 3};
time = dateArray{:, 4};
date = strcat(month,{' '},day,{' '},year,{' '},time);
frewind(fileID)
% Make date available in base workspace
assignin('base', 'date', date);

%% X-Ray Diffraction Data
% Initialize diffraction data variables.
formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*[^\n\r]';
% Determine number of header rows
tline = fgetl(fileID);
n = 0;
startRow = 0;
while ischar(tline) && startRow==0;
   n = n + 1;
   if strcmp(tline,'DATA: ');
       startRow = n + 1;
   end
   tline = fgetl(fileID);
end
frewind(fileID);
% Read diffraction data
medDataRaw = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
% Make medData available in base workspace
assignin('base', 'medDataRaw', medDataRaw);