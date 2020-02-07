%%  [distance] = jumpCalculator(output_of_reduceDim)
%   
%   This code will take the output of reduceDim and create mean step
%   distance vectors across repeated iterations of the t-SNE algorithm,
%   compiling participants into a master matrix of mean step distance
%   vectors separated by run.
%
%   INPUT: 
%       - reducedData:
%          (num_participants) x (num_runs) cell array. If more than 1
%          iteration of the t-SNE algorithm was requested in the previous
%          step, then each cell array will be a matrix of shape
%          (num_repetitions x num_timepoints x 2). 
%   OUTPUT:
%       - distance:
%           a cell array with shape 1 x num_runs, where each cell contains
%           a (num_participants x num_timepoints matrix). 
%   
%   Last updated: February 06, 2020 | Written by Julie Tseng
%% BEGIN

function distance = jumpCalculator(reducedData)

    % get some values
    num_ppts = size(reducedData, 1);
    num_runs = size(reducedData, 2);
    num_its = size(reducedData{1},1);

    % initialize the result struct
    distance = cell(1,num_runs);

    for r = 1:num_runs % for each run
        for ppt = 1:num_ppts % for each participant
            total_time = size(reducedData{ppt,r},2) - 11; % get num TRs after omitting first/last few timepoints
            diffY = NaN(num_its, total_time); % initialize struct
            for its = 1:num_its % for each iteration of t-SNE
                this_iter = squeeze(reducedData{ppt,r}(its,:,:)); % get that 2D representation
                try
                    diffY(its,1:total_time) = ... % calculate mahalanobis distance
                        diag(squareform(pdist(this_iter(6:(total_time+6),:), ...
                        'mahalanobis')), 1)'; 
                catch
                    diffY(its,:) = NaN;
                end
            end
            distance{r}(ppt,:) = nanmean(diffY,1);
        end
        clear diffY this_iter total_time
    end

end
