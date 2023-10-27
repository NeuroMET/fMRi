# Resting state functional MRI: connectivity measurements in the NeuroMET projects
This is the code repository which was created for the paper “Plasma p-Tau181 and GFAP track 7T MR-based changes in Alzheimer’s disease”, Göschel L, 2023.

###### 1. Preprocessing (fMRIprep, see scripts/fmriprepcmd)
An example fMRIprep output file can be found under example_fmriprep.md. The pipeline is described in the method section of this file.

###### 2. Denoising, matrix extraction and averaging across networks (see notebooks/Functional_connectivities.ipynb)
Our denoising strategy involved the selection from fmriprep confounds of 24 motion parameters, four global signal parameters, the white matter (WM) and cerebrospinal fluid (CSF) components from the anatomical component-based correction (aCompCor, two components) and the noise independent components from ICA-AROMA. Additionally, a smoothing with full-width half-maximum of 6 mm and a filter with passband between 0.008 Hz and 0.1 Hz pass was applied. The denoising pipeline was implemented with NiLearn (Abraham et al., 2014).

###### 3. (see notebooks/Functional_connectivities.ipynb)
Using the Schaefer Atlas 2018 (7 Networks, 400 ROI, (Schaefer et al., 2018)), the functional connectivities were extracted and Pearson’s correlation employed as a connectivity measure. The connectivity matrices were extracted as z-scores with NiLearn. Connectivity values of 0 and below were excluded. The lower-triangular matrix was selected for each subject. From the matrix, functional connectivity values were extracted for the ROIs of the default mode network (DMN) and the Salience network (Sal). Functional connectivity values were averaged to a single value for each of the two networks.
