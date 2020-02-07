# Placeholder for a real name

Can we identify the flights and perches of thought (James, 1890) directly from the brain? We showed that the network transition timepoints identified by this pipeline are aligned to high-level cognitive state changes and suggest that characterizing these transitions is a method to characterize mentation (i.e., the act of thinking) directly from neural signal [(Tseng & Poppenk, 2019)](https://www.biorxiv.org/content/10.1101/576298v4). The following pipeline will take multidimensional timeseries data, use a non-linear dimensionality reduction technique (t-SNE) to project the high dimensional data onto a two-dimensional state space, and identify potential jumps of interest from this reduced space. 

- [System Requirements](#system-requirements)
- [Installation Guide](#installation-guide)
- [How to Use](#how-to-use)
- [Demo](#demo)

## System Requirements

This pipeline was originally developed on MATLAB (r2017a) and run on a Linux server. If the Parallel Computing Toolbox is available to you, then `parfor` is used to process multiple participants' data at once in various segments. No custom/non-standard hardware was used.

## Installation Guide

Download this function library and ensure that the path to its folder is visible to MATLAB. 

## How to Use

The following section lays out the pipeline, including expected input/outputs and a high-level description of the steps carried out in each function. If you are looking for how to obtain the 15-network representation of brain activity from your 4D functional data, see the [Appendix A: Network Representation](#Appendix-A:-Network-Representation) section at the bottom. 

+ `reduceDim.m`:
+ `jumpAnalyzer.m`:
+ `analyzeTrajectory.m`:
+ `findManyPks.m`:

## Appendix-A:-Network-Representation

Should you wish to transform fMRI data into the same network space as in our paper, you will require:
+ Spatial maps from the Human Connectome Project (HCP) that are the output of group-ICA and group-PCA on the 3T resting state dataset
+ FSL's [dual regression function](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/DualRegression)
+ Your 4D fMRI data

Then, steps are as follows:
1. Match the resolution of the spatial maps from HCP to that of your functional data. 
2. Use FSL's command-line dual regression function to regress the spatial maps into your functional data. The key output here is the stage 1 output, which is a `dr_stage1_*.txt` file containing a row for each TR and a column for each network. 
