% MED2Int - Function for converting counts data from a med file to relative
% peak intensitites.
% Last updated: June 14, 2015
% Code written by Matthew L. Whitaker
function MED2Int(medDataRaw)

%% X-Ray Diffraction Data
% Allocate diffraction array to column variable names
D1Data = medDataRaw{:, 1};
D2Data = medDataRaw{:, 2};
D3Data = medDataRaw{:, 3};
D4Data = medDataRaw{:, 4};
D5Data = medDataRaw{:, 5};
D6Data = medDataRaw{:, 6};
D7Data = medDataRaw{:, 7};
D8Data = medDataRaw{:, 8};
D9Data = medDataRaw{:, 9};
D10Data = medDataRaw{:, 10};

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
% Make relative intensity available in base workspace
relInt=[D1DataN,D2DataN,D3DataN,D4DataN,D5DataN,D6DataN,D7DataN,D8DataN,D9DataN,D10DataN];
assignin('base', 'relInt', relInt);