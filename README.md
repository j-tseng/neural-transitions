# Placeholder for a real name

Can we identify the flights and perches of thought (James, 1890) directly from the brain? We showed that the network transition timepoints identified by this pipeline are aligned to high-level cognitive state changes and suggest that characterizing these transitions is a method to characterize mentation (i.e., the act of thinking) directly from neural signal (Tseng & Poppenk, 2019). 

- [Overview](#overview)
- [Documentation](#documentation)
- [System Requirements](#system-requirements)
- [MATLAB Toolboxes](#matlab-toolboxes)
- [Installation Guide](#installation-guide)
- [License](#license)

# Overview

The following section lays out assumptions on the input data and pseudocode for the pipeline.

## Input to Pipeline

In our work, brain activity was represented as the level of activation across 15 different brain networks, and this served as the starting point of the MATLAB pipeline. Users are free to use as input any representation of brain activity they wish. 

### Network Representation

Should you wish to transform fMRI data into the same network space as in our paper, you will require:
+ Spatial maps from the Human Connectome Project (HCP) that are the output of group-ICA and group-PCA on the 3T resting state dataset
+ FSL's [dual regression function](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/DualRegression)
+ Your 4D fMRI data

Then, steps are as follows:
1. Match the resolution of the spatial maps from HCP to that of your functional data. 
2. Use FSL's command-line dual regression function to regress the spatial maps into your functional data. The key output here is the stage 1 output, which is a `dr_stage1_*.txt` file containing a row for each TR and a column for each network. 

## Pseudocode

+ `reduceDim.m`:
+ `jumpAnalyzer.m`:
+ `analyzeTrajectory.m`:
+ `findManyPks.m`:
