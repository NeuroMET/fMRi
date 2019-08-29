function y = fmc6_3Dto4D(path, subject)

    %% Clear  variables  and  command  window
    clear clc
    clear matlabbatch;

    tic       
    %% Paths

    nii3d_path = strcat(path, '/', subject, '/bold/3D_bold');
    bold_path = strcat(path, '/', subject, '/bold');
    fieldmap_path = strcat(path, '/', subject, '/fieldmap');
    
    %% 3D to 4D File Conversion
    %Batch Editor --> SPM --> Tools --> Utils --> 3D to 4D File Conversion
    %•	3D volumes: Enter the realigned and resliced 3D mbep2-bold-images (prefix=u; Caution! No other files)
    %•	Output Filename: ru$subject.bold_FieldCorr
    %•	Data Type: Same
   
%%
    u_nii3d_path = strcat(path, '/', subject, '/bold/3D_bold');
    u_nii3d_select = spm_select('FPList', nii3d_path, strcat('^u', subject, '.bold_orig_*'));
    u_nii3d_data = cellstr(u_nii3d_select);

    matlabbatch{1}.spm.util.cat.vols = u_nii3d_data;
    matlabbatch{1}.spm.util.cat.name = strcat(bold_path, '/ru', subject, '.bold_FieldCorr.nii');
    matlabbatch{1}.spm.util.cat.dtype = 0;
    spm_jobman('run', matlabbatch);
    toc

end
    
    