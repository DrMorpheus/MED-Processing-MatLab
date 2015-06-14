% E2Dspc - Function for converting med file channel information to d-space
% using energy calibration data, either from med or EDF.
% Last updated: June 14, 2015
% Code written by Matthew L. Whitaker
function E2Dspc(ECalData)

%% Energy Calibration Data
% Allocate calibration array to column variable names
D1Cal = ECalData(:, 1);
D2Cal = ECalData(:, 2);
D3Cal = ECalData(:, 3);
D4Cal = ECalData(:, 4);
D5Cal = ECalData(:, 5);
D6Cal = ECalData(:, 6);
D7Cal = ECalData(:, 7);
D8Cal = ECalData(:, 8);
D9Cal = ECalData(:, 9);
D10Cal = ECalData(:, 10);

%% Data Conversion
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
% Make d-spacing data available in base workspace
dspc=[D1DSpc,D2DSpc,D3DSpc,D4DSpc,D5DSpc,D6DSpc,D7DSpc,D8DSpc,D9DSpc,D10DSpc];
assignin('base', 'dspc', dspc);