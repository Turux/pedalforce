function TEST01 = rawimport(filepath)

%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Users/turux/Desktop/downsample/20171130_TEST01.tsv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2017/12/08 12:17:50

%% Initialize variables.
%filename = '/Users/turux/Desktop/downsample/20171130_TEST01.tsv';
if nargin == 0
[filename, filepath] = uigetfile('*.xls','Select the Pedals Raw File');
filename = fullfile(filepath, filename);
else
filename = dir(fullfile(filepath,'*.xls'));
filename = fullfile(filepath, filename.name);
end
delimiter = '\t';
startRow = 10;

%% Format for each line of text:
%   column2: double (%f)
%	column3: double (%f)
%   column4: double (%f)
%	column5: double (%f)
%   column6: double (%f)
%	column7: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
TEST01 = table(dataArray{1:end-1}, 'VariableNames', {'Digitaltrigger','Fe_l','Fu_l','Fe_r','Fu_r','angle'});

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;