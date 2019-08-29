function y = fmc4_CalculateVDM(path, subject)

    %% Clear  variables  and  command  window
    clear clc
    clear matlabbatch;


    %% Calculate VDM
    %Batch Editor --> SPM --> Tools --> FieldMap --> Calculate VDM
    %•	Calculate a voxel displacement map (VDM) from presubtracted phase and magnitude field map data. --> This option expects a single magnitude image and a single phase image resulting from the %subtraction of two phase images (where the subtraction is usually done automatically by the scanner software). The phase image will be scaled between +/- PI.
    %•	Field map: choose presubtracted phase and magnitude data
    %•	Select a single phase image and a single magnitude image (if two then --> Image with shorter TE)
    %•	FieldMap defaults: Default values
   

 tic

    bold_path = strcat(path, '/', subject, '/bold');
    fieldmap_path = strcat(path, '/', subject, '/fieldmap');

    magnitude_select = spm_select('FPList', fieldmap_path, strcat('^r', subject, '.magnitude1.nii'));
    magnitude_data = cellstr(magnitude_select);
    phase_select = spm_select('FPList', fieldmap_path, strcat('^r', subject, '.phase.nii'));
    phase_data = cellstr(phase_select);
    epi_select = spm_select('FPList', bold_path, strcat('^', subject, '.bold_orig.nii'));
    epi_data = cellstr(epi_select);
    %% Set Parameters
    calcvdm_echo_times = [6 7.02];
    calcvdm_mask_brain = 1;
    calcvdm_blip = -1;
    calcvdm_total_epi_readout_time = 76.63;
    calcvdm_epi_fm = 0;
    calcvdm_match_vdm = 0;
    calcvdm_session_name = 'run';
    calcvdm_write_unwarped = 1;
    calcvdm_anat = '';
    calcvdm_match_anat = 0;
    calcvdm_ajm = 0;
    calcvdm_session_epi = '';
    calcvdm_method = 'Mark3D';
    calcvdm_matchvdm = 1;
    calcvdm_sessname = 'session';
    calcvdm_writeunwarped = 0;
    calcvdm_anat = '';
    calcvdm_matchanat = 0;
    %% Prepare batch
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.phase = phase_data;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.data.presubphasemag.magnitude = magnitude_data;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.et = calcvdm_echo_times;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.maskbrain = calcvdm_mask_brain;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.blipdir = calcvdm_blip;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.tert = calcvdm_total_epi_readout_time;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.epifm = calcvdm_epi_fm;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.ajm = calcvdm_ajm;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.method = calcvdm_method;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.fwhm = 10;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.pad = 0;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.uflags.ws = 1;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.template = {'/opt/spm12/toolbox/FieldMap/T1.nii'};
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.fwhm = 5;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.nerode = 2;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.ndilate = 4;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.thresh = 0.5;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.defaults.defaultsval.mflags.reg = 0.02;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.session.epi = epi_data;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.matchvdm = calcvdm_matchvdm;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.sessname = calcvdm_sessname;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.writeunwarped = calcvdm_writeunwarped;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.anat = calcvdm_anat;
    matlabbatch{1}.spm.tools.fieldmap.calculatevdm.subj.matchanat = calcvdm_matchanat;
    spm_jobman('run', matlabbatch);
    toc;
end
