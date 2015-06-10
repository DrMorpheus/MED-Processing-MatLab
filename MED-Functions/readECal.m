% readECal - Function for reading energy calbration data stored in the  
% header of a med file.
% Last updated: June 9, 2015
% Code written by Matthew L. Whitaker
function readECal(filename)

%% Energy Calibration Data
% Initialize calibration variables.
delimiter = ' ';
fileID = fopen(filename,'r');
startRow = 8;
endRow = 11;
formatSpec = '%*s%f%f%f%f%f%f%f%f%f%f%*[^\n\r]';
% Read calibration data.
ECalData = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow-1, 'ReturnOnError', false);
% Clear temporary calibration variables
clearvars startRow endRow formatSpec dataArray1 ans;
fclose(fileID);
assignin('base', 'ECalData', ECalData);
