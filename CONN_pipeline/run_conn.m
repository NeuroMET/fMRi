clear all; clc;
clear BATCH;
name = 'conn_8.mat';
working_dir = pwd;
subs = dir(strcat(pwd, '/*Ne*'));
subs = {subs.name};
sub_nr = length(subs);

% Make a cell array with anatomical and functional images
for i=1:sub_nr
    sub = subs(i);
    bolds{i} = fullfile(pwd, sub, strcat('bold/ru', sub, '.bold_FieldCorr.nii'));
    anats{i} = fullfile(pwd, sub, strcat('anat/', sub, '.mUNIbrain_DENskull_SPMmasked_MNIcoregWarped.nii'));
end

BATCH.gui = 0;
BATCH.filename=fullfile(pwd,name)
BATCH.Setup.RT = 2.2;
BATCH.Setup.isnew=1;
BATCH.Setup.nsubjects=sub_nr;
for i=1:sub_nr
    BATCH.Setup.functionals{i}{1}=bolds{i};
    BATCH.Setup.structurals{i}=anats{i};
end

%% Setup
BATCH.Setup.overwrite = 1;
BATCH.Setup.nsubjects = sub_nr;
BATCH.Setup.nsessions = 1;
BATCH.Setup.RT = 2.2;
BATCH.Setup.preprocessing.fwhm = 6;
BATCH.Setup.preprocessing.steps = 'default_mni';
BATCH.Setup.analyses = [1,2];
BATCH.Setup.voxelresolution = 2;
BATCH.Setup.preprocessing.sliceorder = [0.0, 992.5, 1987.5, 772.5, 1765.0, 550.0, 1545.0, 330.0, 1325.0, 110.0, 1102.5, 2097.5, 882.5, 1875.0, 662.5, 1655.0, 440.0, 1435.0, 220.0, 1212.5, 0.0, 992.5, 1987.5, 772.5, 1765.0, 550.0, 1545.0, 330.0, 1325.0, 110.0, 1102.5, 2097.5, 882.5, 1875.0, 662.5, 1655.0, 440.0, 1435.0, 220.0, 1212.5, 0.0, 992.5, 1987.5, 772.5, 1765.0, 550.0, 1545.0, 330.0, 1325.0, 110.0, 1102.5, 2097.5, 882.5, 1875.0, 662.5, 1655.0, 440.0, 1435.0, 220.0, 1212.5, 0.0, 992.5, 1987.5, 772.5, 1765.0, 550.0, 1545.0, 330.0, 1325.0, 110.0, 1102.5, 2097.5, 882.5, 1875.0, 662.5, 1655.0, 440.0, 1435.0, 220.0, 1212.5];
BATCH.parallel.N = 4; %From Tools / HPC Options, select "Background process (Unix,Mac)"
BATCH.Setup.done=1;


%%Denoising
%BATCH.Denoising = 1;
BATCH.Denoising.done = 0;
BATCH.Denoising.overwrite = 1;

%%First Level
BATCH.Analysis.overwrite = 1;
BATCH.Analysis.sources = {'networks.DefaultMode.PCC'};
BATCH.Analysis.type = [1 2];
BATCH.Analysis.done = 1;

conn_batch(BATCH);
