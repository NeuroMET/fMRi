function y = fmc5_ApplyVDM(path, subject)

    %% Clear  variables  and  command  window
    clear clc
    clear matlabbatch;
    
    %% Apply VDM
    %Batch Editor --> SPM --> Tools --> FieldMap --> Apply VDM
    %•	Session - Images: Enter all realigned 3D EPI-bold-images (Caution, Name of 3D files is not changed after realignment! Dont use other files)
    %•	Session – Fieldmap (vdm* file): Enter the vdm*phase-image (derived from Calculate VDM)
    %Reslice options:
    %•	Distortion direction: Posterior-Anterior (Y)
    %•	Rescliced images: All Images (1..n)
    %•	Interpoaltion: 4th Degree B-Spline
    %•	Wrapping: No wrap
    %•	Masking: Mask images
    %•	Filename Prefix: u

%%
     tic       
    nii3d_path = strcat(path, '/', subject, '/bold/3D_bold');
    bold_path = strcat(path, '/', subject, '/bold');
    fieldmap_path = strcat(path, '/', subject, '/fieldmap');
    
    nii3d_select = spm_select('FPList', nii3d_path, strcat('^', subject, '.bold_orig_*'));
    nii3d_data = cellstr(nii3d_select);
    
    vdm_select = spm_select('FPList', fieldmap_path, '^vdm5_*');
    vdm_data = cellstr(vdm_select);

    applyvdm_pedir = 2;
    applyvdm_which = [2 0];
    applyvdm_rinterp = 4;
    applyvdm_wrap = [0 0 0];
    applyvdm_mask = 1;
    applyvdm_prefix = 'u';

    matlabbatch{1}.spm.tools.fieldmap.applyvdm.data.scans = nii3d_data;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.data.vdmfile = vdm_data;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.pedir = applyvdm_pedir;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.which = applyvdm_which;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.rinterp = applyvdm_rinterp;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.wrap = applyvdm_wrap;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.mask = applyvdm_mask;
    matlabbatch{1}.spm.tools.fieldmap.applyvdm.roptions.prefix = applyvdm_prefix;
	spm_jobman('run', matlabbatch);
    toc;
end
    
    