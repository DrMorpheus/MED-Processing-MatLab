function [timestamp,file] = medload(filename)
%medload - Function for importing data from an med file, from scratch


%% Initialize variables.
delimiter = ' ';
fileID = fopen(filename,'r');
startRow = 3;
endRow = 3;
formatSpec = '%*s%s%s%s%s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Read timestamp data
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);

%% Allocate imported array to column variable names
month = dataArray{:, 1};
day = dataArray{:, 2};
year = dataArray{:, 3};
time = dataArray{:, 4};

%% Parse Filename Data
fullpath=strsplit(filename,'\');
fullfile=fullpath{6};
filesplit=strsplit(fullfile,'.');
fileext=filesplit(2);
file=filesplit(1);

%% Close the text file.
fclose(fileID);
