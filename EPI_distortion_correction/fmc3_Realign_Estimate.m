function y = fmc3_Realign_Estimate(path, subject)

    %% Clear  variables  and  command  window
    clear clc
    clear matlabbatch;

    tic       
    %% Realign: Estimate
    %Batch Editor --> SPM --> Spatial --> Realign --> Realign: Estimate
    %•	Session: Enter all 3D fMRi EPI-bold-files
    %•	Estimation Options: Keep everything default, except for Num Passes: Register to first
    %Caution! Output files have the same name as input files
    
    %%
    nii3d_path = strcat(path, '/', subject, '/bold/3D_bold');
    nii3d_select = spm_select('FPList', nii3d_path, strcat(subject, '.bold_orig'));
   
    nii3d_data = {cellstr(nii3d_select)}

    realign_quality = 0.9;
    realign_sep = 4;
    %Smoothing
    realign_fwhm = 5;
    %Register to first image = 0 (dont use 1, which means register to mean)
    realign_rtm = 0;
    realign_interp = 2;
    realign_wrap = [0 0 0];
    realign_weight = '';

    matlabbatch{1}.spm.spatial.realign.estimate.data = nii3d_data;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.quality = realign_quality;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.sep = realign_sep;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.fwhm = realign_fwhm;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.rtm = realign_interp;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.interp = 2;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.wrap = realign_wrap;
    matlabbatch{1}.spm.spatial.realign.estimate.eoptions.weight = realign_weight;
    spm_jobman('run', matlabbatch);
    toc;
end
    
    