%%  [result] = analyzeTrajectory(output_of_findManyPks, TR)
%
%   This function takes peaks identified as transition points and
%   calculates desired measures based on the trajectories. 
%
%   Input:
%       - pks:
%           Output of findManyPks function which contains identified peaks
%           associated timepoints and uses that to calculate the duration
%           or dwell time of each state and a transition rate per minute. 
%       - TR:
%           Repetition time of scan **IN SECONDS**; need this for 
%           calculation of transition rates (per minute). 
%
%   Output:
%       - Transition rate in an array of size (ppt x num_runs)
% 
%   Last updated: February 6, 2020 | Written by Julie Tseng

function trans_rt = analyzeTrajectory(pks, TR)

     if ~(exist('TR', 'var'))
        error('You must specify the TR in seconds.')
     end

     num_runs = length(fieldnames(pks));
     
    for r = 1:num_runs
        num_tps = size(pks.(sprintf('run%d',r)).bin,2);
        trans_rt(:,r) = cellfun(@length, pks.(sprintf('run%d',r)).idx)/...
            (num_tps*TR/60);
    end

end