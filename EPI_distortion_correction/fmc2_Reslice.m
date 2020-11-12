function y = fmc2_Reslice(path, subject)

    %% Clear  variables  and  command  window
    clear clc
    clear matlabbatch;

    tic       
    
    %% Reslice of FieldMap images
    % Fieldmap (magniture and phase) images need to be resliced, because they are smaller than the EPI fMRI image (otherwise the latter one would be cut later)
    
    % SPM GUI:
    % Batch Editor --> SPM --> Spatial --> Coregister --> Coregister: Reslice
    % •	Session: Enter the 4D mbep2-bold-image
    % •	Output directory: Selection needs to be made in the right window!

    %%
    %subjectnr = randperm(1);
    nii4d_path = strcat(path, '/', subject, '/bold');
    nii3d_path = strcat(path, '/', subject, '/bold/3D_bold');
    fieldmap_path = strcat(path, '/', subject, '/fieldmap');
    
    nii3d_path = strcat(path, '/', subject, '/bold/3D_bold');
    nii3d_select = spm_select('FPList', nii3d_path, strcat(subject, '.bold_orig'));
    nii3d_select = spm_select('FPList', nii3d_path, strcat(subject, '.bold_orig_00001'));
    nii3d_data = cellstr(nii3d_select);

    nii4d_filename = strcat(subject, '.bold_orig.nii');
    nii4d_select = spm_select('FPList', nii4d_path, nii4d_filename);
    nii4d_data = cellstr(nii4d_select);
    magnitude_select = spm_select('FPList', fieldmap_path, strcat('^', subject, '.magnitude1.nii'));
    magnitude_data = cellstr(magnitude_select);
    phase_select = spm_select('FPList', fieldmap_path, strcat('^', subject, '.phase.nii'));
    phase_data = cellstr(phase_select);
    to_reslice = [magnitude_data; phase_data];
    
    matlabbatch{1}.spm.spatial.coreg.write.ref = nii3d_data;
    matlabbatch{1}.spm.spatial.coreg.write.source = to_reslice;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.interp = 4;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.coreg.write.roptions.mask = 0;
    matlabbatch{1}.spm.spatial.coreg.write.roptions.prefix = 'r';

    %batch{subjectnr} = matlabbatch;
    %spm_jobman('run', batch{subjectnr});
    spm_jobman('run', matlabbatch);
    toc;
end
    
    