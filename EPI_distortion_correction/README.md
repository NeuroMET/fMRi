# Fieldmap distortion correction

Magnetic field inhomogeneities distortion correction with field maps for rsfMRI BOLDs

## Requirements

1) MatLab ()
2) SPM12

## Example usage

### Accepted directory structure
```
|subject
| |
| |--- bold
| |      |--subject.bold_orig.nii
| |
| |--- fieldmap
| |       |-- subject.magnitude1.nii
| |       |-- subject.magnitude2.nii
| |       |-- subject.phase.nii  

```

### Usage
1) Adjust data_path, line 23 of X2_FieldMap_Correction_bold.m
2)  Adjust subject_prefix on line 24
3) from matlab `FieldMap_Correction_bold(subject_ids_vector, ses_suffix)` where subject number vector should be like [1:10] for subject from `subject_prefix``001``ses_suffix` to `subject_prefix``010``ses_suffix`

Final output will be under the main subject directory
