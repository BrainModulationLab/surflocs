function [options] = dbs_coregctspm(options)
%% Coregister and reslice
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Coregistration of Preop and Postop MRIs                                %
% for Ablation Volume Reconstruction                                     %
% Requires uncompressed NiFTI (*.nii) Images:
%     1) Preop high resolution MRI without contrast                      %
%     2) 1 month Postop MRI with contrast                                %
% 3-D volumetric reconstructionswill be performed on Image 1
% Postoperative ablation volume will be reconstructed from image 2.
% Use Freesurfer mri_convert (*.dcm to *.nii) or recon-all + mri_convert
% (*.mgz to *.nii). Requires:
%     ~/PtId_FS/PtId_preop_T1.nii and 
%     ~/PtId_FS/PtId_postop_T1.nii

% After running the .m file open Preop (source) followed by Postop
% (reference) images. DONE.

% Requires: Matlabbatch availabe here:
% (https://sourceforge.net/projects/matlabbatch/)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Coregister and reslice the source (moves) to reference (doesn't move)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Navigate to '...PtId_FS/output' folder and select Preop NIfTI 
% Press Open Select Postop NIfTI and Press Open again
% cd(cellstr(uipatdirs))
clc
% Reference - try:
path2ref = char(options.uipatdirs);
referencei = 'postopmri.nii';
if exist(fullfile(path2ref,referencei)) % expected file 
    disp('loading postopmri.nii....')
else
    disp('Please Choose Postop MRI as Reference....')
    [referencei, path2ref] = uigetfile('*.nii','Please Choose Postop MRI as Reference....',char(options.uipatdirs));
    % reformat file structure
    copyfile(fullfile(path2ref,referencei),[char(options.uipatdirs),filesep,'postopmri.nii'])
    path2ref = char(options.uipatdirs);
    referencei = 'postopmri.nii';
end

% Source - try:
path2source = char(options.uipatdirs);
sourcei = 'preopct.nii';
if exist(fullfile(path2source,sourcei)) % expected file 
    disp('loading preopct.nii.....')
else
    clc; disp('Please Choose Preop CT as Source....')
    [sourcei, path2source] = uigetfile('*.nii','Please Choose Preop CT as Source....',path2ref);
    % reformat file structure
    copyfile(fullfile(path2source,sourcei),[char(options.uipatdirs),filesep,'preopct.nii'])
    path2source = char(options.uipatdirs);
    sourcei = 'preopct.nii';
end

%% Coregister with SPM Commands
% Requires SPM12 in matlabpath
% SPM Commands

matlabbatch{1}.spm.spatial.coreg.estwrite.ref = {[fullfile(path2ref,referencei) ',1']};
matlabbatch{1}.spm.spatial.coreg.estwrite.source = {[fullfile(path2source,sourcei) ',1']};
matlabbatch{1}.spm.spatial.coreg.estwrite.other = {''};
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.interp = 1;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.mask = 0;
matlabbatch{1}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';

% Executes the SPM commands
spm('defaults','FMRI');
spm_jobman('serial',matlabbatch);
end