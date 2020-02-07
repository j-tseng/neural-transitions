%% DEMO MAIN FILE
%  Use the structure here to execute the pipeline on your data.

% Set up some inputs
mainFolder = 'path/to/demo/demo_data/'; % put in the filepath to the data
num_runs = 1; % specify number of runs
its = 5; % how many dimensions in resulting meta-state space?

% transform network representation to meta-state space
[reducedData, subjID] = reduceDim(mainFolder, num_runs, its);

% calculate mean step distance vectors for participants
distance = jumpCalculator(reducedData);

% identify transition and meta-stable timepoints
pks = findManyPks(distance);

% calculate measures of mental dynamics
trans_rt = analyzeTrajectory(pks, 1); % mentation rate
conformity = groupAlign(distance); % TASK ONLY - conformity