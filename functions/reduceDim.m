%%  [result, subjectIDs] = reduceDim(pathtofolder, runs, dimension, its)
%
%   This function takes network rep timeseries data and transforms it 
%   to the t-SNE 2D state space. It will check whether parfor is available
%   to use - if so, it will parallelize. 
%
%   Input:
%       - filepath: 
%           String path to folder containing each participant folder. 
%       - num_runs:
%           Number of expected runs for each participant.
%       - dim: (default 2)
%           Desired reduced dimensionality (2 or 3). 
%       - its: (default 10)
%           Number of repetitions of t-SNE that should be carried out.
%
%   Output:
%       - reducedData:
%           A (num_participants x num_runs) cell containing the reduced
%           dimensionality data. Each cell contains an array with
%           dimensions (num_iterations x num_timepoints x 2).
%       - subjID:
%           Subject ID attached to each row of reducedData.
% 
%   Last updated: February 6, 2020 | Written by Julie Tseng

%%  BEGIN

function [reducedData, subjID] = reduceDim(filepath, num_runs, dim, its)

    % Set parameters
    if ~(exist(filepath, 'dir'))
        error('You have specified an invalid folder path.')
    else
        mainFolder = filepath; 
    end
    if ~(exist('num_runs', 'var'))
        error('You did not specify how many runs for each participant.')
    else
        r = num_runs;
    end
    if ~(exist('dim', 'var'))
        dim = 2;
    end
    if ~(exist('its', 'var'))
        its = 10;
    end
    
    
    % Generate list of subject IDs
    subjID = extractfield(dir(mainFolder), 'name');
    subjID(1:2) = [];
    
    % do the work
    if exist('parfor','builtin') == 5
        parfor i = 1:length(subjID) % for every participant
            for run = 1:r           % and for each of their fMRI runs
                filename = strcat(mainFolder,'/',subjID{i},... % load their data
                    '/dr_stage1_subject0000',num2str(run-1),'.txt');

                if exist(filename, 'file') == 2 % if that file exists, proceed with processing
                    tmp = load(char(filename)); % load
                    total_time = size(tmp,1); % grab time
                    preshape = smooth(tmp); % smooth by 5
                    smoothed = reshape(preshape, total_time, []); 
                    if its > 1 % handling if there's only 1 executed
                        for rep = 1:its
                            tSNE_out = tsne(smoothed, 'NumDimensions', dim, 'Perplexity', 30);
                            reducedData{i,run}(its,:,:) = tSNE_out;
                        end
                    else
                        tSNE_out = tsne(smoothed, 'NumDimensions', dim, 'Perplexity', 30);
                        reducedData{i,run} = tSNE_out;
                    end
                else
                    reducedData{i,run} = NaN;
                end
            end
        end
    end
end