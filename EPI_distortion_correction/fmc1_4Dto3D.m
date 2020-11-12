function y = fmc1_4Dto3D(path, subject)

    %% Clear  variables  and  command  window
    clear clc
    clear matlabbatch;
   
    
	%tic toc = Timer, how long script runs
    %tic       
    %% 4D to 3D File Conversion
    % Batch Editor --> SPM  --> Utils --> 4D to 3D File Conversion
    %•	Session: Enter the 4D mbep2-bold-image
    %•	Output directory: Selection needs to be made in the right window!
    %
    disp(subject);
    subjectnr = str2num(subject);
    nii4d_path = strcat(path, '/', subject, '/bold');
    nii3d_path = strcat(path, '/', subject, '/bold/3D_bold');
    disp(nii4d_path);
    nii4d_filename = strcat(subject, '.bold_orig.nii');
    disp(nii4d_filename);
    nii4d_select = spm_select('FPList', nii4d_path, nii4d_filename);
    nii4d_data = cellstr(nii4d_select);

	%Pass parameters to jobman
    matlabbatch{1}.spm.util.split.vol = nii4d_data;
    matlabbatch{1}.spm.util.split.outdir = cellstr(nii3d_path);
    batch{1} = matlabbatch;
    %Run batch
    spm_jobman('run', batch{1});
    %toc;
    %%  4D to 3D File Conversion
end
    
    