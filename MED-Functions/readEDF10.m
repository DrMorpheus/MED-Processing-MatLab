% readEDF10 - Function for reading energy calbration data stored in an EDF  
% file (10 detectors) output via energy calibration in Plot85.
% Last updated: June 11, 2015
% Code written by Matthew L. Whitaker
function readEDF10(filename)

%% Energy Calibration Data
% Initialize calibration variables.
delimiter = ' ';
fileID = fopen(filename,'r');
formatSpec = '%f%*s%*[^\n\r]';
startRow = [1,5,7,11,13,17,19,23,25,29,31,35,37,41,43,47,49,53,55,59];
endRow = [3,5,9,11,15,17,21,23,27,29,33,35,39,41,45,47,51,53,57,59];
% Read calibration data.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    dataArray{1} = [dataArray{1};dataArrayBlock{1}];
end
fclose(fileID);
% Format data to ECalData specs
ECalData=[dataArray{1}(1:4),dataArray{1}(5:8),dataArray{1}(9:12),dataArray{1}(13:16),dataArray{1}(17:20),dataArray{1}(21:24),dataArray{1}(25:28),dataArray{1}(29:32),dataArray{1}(33:36),dataArray{1}(37:40)];
% Make ECalData available in base workspace
assignin('base', 'ECalData', ECalData);
