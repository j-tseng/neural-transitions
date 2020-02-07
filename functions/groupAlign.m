%%  [conformity = groupAlign(output_of_jumpCalculator)
%
%   This function takes the mean step distance signal outputted by
%   jumpCalculator and returns the conformity of each participant to the group. 
%
%   Input:
%       - distance:
%           A cell array with mean step distance vectors for each run. 
%
%   Output: 
%       - Conformity in an array of size (ppt x num_runs)
% 
%   Last updated: February 6, 2020 | Written by Julie Tseng

function conformity = groupAlign(distance)

num_runs = length(distance);

for r = 1:num_runs
    num_ppts = size(distance{r},1);
    for ppt = 1:num_ppts
        single_sig = distance{r}(ppt,:);
        median_others = nanmedian(distance{r}(setdiff(1:num_ppts,ppt),:));
        tmp_corr = corrcoef(log(single_sig), log(median_others));
        conformity(ppt,r) = atanh(tmp_corr(2,1));
    end
    clear single_sig median_others tmp_corr
end

end