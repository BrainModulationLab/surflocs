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
% clear
% clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Navigate to '...PtId_FS/output' folder and select Preop NIfTI 
% Press Open Select Postop NIfTI and Press Open again
% cd(cellstr(uipatdirs))
clc
disp('Please Choose Postop MRI as Reference....')
[referencei, path2ref] = uigetfile('*.nii','Please Choose Postop MRI as Reference....',char(options.uipatdirs));
clc; disp('Please Choose Preop CT as Source....')
[sourcei, path2source] = uigetfile('*.nii','Please Choose Preop CT as Source....',path2ref);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%a
% Check Naming Structure
if ~strcmp(referencei,'postopmri.nii') && ~exist([char(options.uipatdirs),filesep,'postopmri.nii'])
    copyfile(fullfile(path2ref,referencei),[char(options.uipatdirs),filesep,'postopmri.nii'])
end
if ~strcmp(sourcei,'preopct.nii') && ~exist([char(options.uipatdirs),filesep,'preopct.nii'])
    copyfile(fullfile(path2source,sourcei),[char(options.uipatdirs),filesep,'preopct.nii'])
end
% options.postopmri.filename = 

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