% Folder where the .mat files are located
folder = 'E:\Bearings\Dataset\Bearing_dataset\inner';

% Get list of all .mat files in the folder
matFiles = dir(fullfile(folder, '*.mat'));

% Initialize an empty array to store the first rows
firstRows = [];

for k = 1:length(matFiles)
    % Load the .mat file
    filePath = fullfile(folder, matFiles(k).name);
    data = load(filePath);
    
    % Check if the file contains "signals" or "signal" and extract the first row
    if isfield(data, 'signals')
        % Extract the first row from "signals"
        firstRow = data.signals(1, :);
    elseif isfield(data, 'signal')
        % Extract the first row from "signal"
        firstRow = data.signal(1, :);
    else
        % If neither "signals" nor "signal" exist, skip the file
        warning('File %s does not contain "signals" or "signal". Skipping...', matFiles(k).name);
        continue;
    end
    
    % Append the first row to the "firstRows" array
    firstRows = [firstRows; firstRow]; %#ok<AGROW>
end

% Save the combined first rows into a new file
save(fullfile(folder, 'combined_first_rows.mat'), 'firstRows');

disp('First rows have been extracted and saved in combined_first_rows.mat');
