function FieldMap_Correction_bold(sublist, suffix)
% Perform SPM-FieldMap Correction of mbep2-images (bold) before reorientation (using SPM12 FieldMap Toolbox)
%##########################################################################################################
%
%
% Changelog
%	09.08.2017 Theresa Köbe - created
%	10.08.2017 Andrea Dell Orco - script, 1st version
%   14.08.2017 Andrea Dell Orco - various parts splitted in more functions
%   21.08.2017 Andrea Dell Orco - 1st working version
%   02.11.2017                  - copyfile ru -> without ru
%
% Docs:
%	http://www.fil.ion.ucl.ac.uk/spm/doc/manual.pdf#Chap:FieldMap FieldMap Toolbox
%
% Examples:
%	https://github.com/lrq3000/neuro_experiments_tools/blob/master/matlab/nifti_4dto3d_convert_recursive/nifti_4dto3d_convert_recursive.m


%%%%%%%%%% Clear previous Matlab Batches:
clear matlabbatch;

%%%%%%%%%% Specify path:
data_path = '/media/drive_s/AG/AG-Floeel-Imaging/02-User/NEUROMET2/EPI_FieldMap_Distortion_Correction'
sub_prefix = 'NeuroMET2_'

%%%%%%%%%% Open Matlab and start the script, e.g.: FieldMap_Correction_bold([1:45], '_T1') --> subject 001_T1-045_T1 will be processed%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spm('defaults','FMRI');
spm_jobman('initcfg');

for i = sublist
    subject = strcat(sub_prefix, sprintf('%03d', i), '_T1'); %subjects(i).name;
    disp(subject);
    try
        %% 4D to 3D File Conversion
        fmc1_4Dto3D(data_path, subject);
        disp('done');
        %% Coregister Reslice
        disp('reslice');
        fmc2_Reslice(data_path, subject);

        %% Realign: Estimate and creation of movement graphs
        fmc3_Realign_Estimate(data_path, subject);
        fmc2_2_realign_txt2graph(data_path, subject);
        %% Calculate VDM
        fmc4_CalculateVDM(data_path, subject);
        %% Apply VDM
        fmc5_ApplyVDM(data_path,subject);
        %% 3D to 4D File Conversion
        fmc6_3Dto4D(data_path,subject);
        %% Copy ru$subject.bold_FieldCorr.nii
         %Note: there is a strange error with file's datetime, anyway the
         %files are correct copied ( same md5!), thats why this try/catch
        try
            copyfile(strcat(data_path, '/', subject, '/',  'bold', '/', 'ru', subject, '.bold_FieldCorr.nii'));
        catch
            disp('');
        end
    catch
        disp(strcat('Error with Subject: ', subject));
    end
end
