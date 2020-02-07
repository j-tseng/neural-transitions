%%  [result] = findManyPks(output_of_jumpAnalyzer)
%
%   This function takes the step distance signal outputted by
%   jumpCalculator and returns the peaks. 
%
%   Input:
%       - distance:
%           A cell array with mean step distance vectors for each run. 
%       - mpp:
%           Min peak prominence setting for the findPks function. 
%
%   Output: pks struct
%       - .runX:
%           results will be separated by run, found in different structs
%       - *.idx:
%           list of indices where peaks are located in cell array
%       - *.bin:
%           binary matrix of (ppt x timepoints) where 1s designate peaks
%           and 0s everywhere else
%       - base_*:
%           as above, but for meta-stable timepoints identified
% 
%   Last updated: February 6, 2020 | Written by Julie Tseng

%% 
function pks = findManyPks(distance, mpp, mpw)
    
    num_runs = length(distance);
    
    % if no mpp specified, grab 80th percentile step distance value
    if ~(exist('mpp', 'var'))
        mpp = prctile(distance{1}(:),80);
    end
    if ~(exist('mpw', 'var'))
        mpw = 10;
    end

    for r = 1:num_runs
        snr = distance{r}; % isolate this set of mean step dist vecs
        
        num_ppts = size(snr,1);
        num_tps = size(snr, 2);

        % initialize some variables
        pksBin = zeros(num_ppts, num_tps); 
        pksBaseBin = zeros(num_ppts, num_tps);
        for ppt = 1:num_ppts
            single_sig = snr(ppt,:); % isolate signal of participant
            
            if isempty(single_sig)
                pksBaseline{ppt} = NaN;
                pksByIdx{ppt} = NaN;
                pksBin(ppt,:) = NaN; 
                pksBaseBin(ppt,:) = NaN;
            else
                [~, single_large] = findpeaks(single_sig,'MinPeakProminence', mpp);
                [~, single_baseline] = findpeaks(-single_sig,'MinPeakWidth', mpw);

                pksBaseline{ppt} = single_baseline;
                pksByIdx{ppt} = single_large;
                pksBin(ppt,single_large) = 1; 
                pksBaseBin(ppt, single_baseline) = 1;
            end
        end

        pks.(sprintf('run%d',r)).idx = pksByIdx;
        pks.(sprintf('run%d',r)).bin = pksBin;
        pks.(sprintf('run%d',r)).base_idx = pksBaseline;
        pks.(sprintf('run%d',r)).base_bin = pksBaseBin;
        
    end

end