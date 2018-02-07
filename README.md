<img src="https://github.com/akapp/surflocs/blob/master/icons/logo_brainmodulationlab_large.png" align="right" />

# SurfLocs

Surface Localizer: 
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Electrode Localization for Intraoperative Cortical Strip Recordings 

## Quick Start Guide

#### Required files
1. Preop MRI 
    - AX FSPGR/BRAVO/MPRAGE/Without contrast
    - `.nii`
2. Preop CT 
    - `.nii`
3. Postop CT or Postop MRI
    - `.nii`
4. Intraoperative Fluoro
    - For each side a single lateral image with visible cortical strip 
    - `.tiff`
5. Cortical reconstruction of Preop MRI using freesurfer [recon-all](https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all). See [Freesurfer Beginner's Guide](https://surfer.nmr.mgh.harvard.edu/fswiki/FreeSurferBeginnersGuide) for detailed instructions.

6.	Reconstruction of Skull from PreopCT (coregistered to PreopMRI).
     - Wavefront `.obj`

#### Bone Reconstruction

    1. Run dbslocs.m in MATLAB
    2.	Choose Patient Directory
    3.	Choose Freesurfer Directory
    4.	Co-register MRI and CT
        a.	Postop MRI - Preop CT
        b.	Preop MRI - Postop CT and Preop MRI - Preop CT
    5.	Wavefront (.obj) reconstruction of Skull from PreopCT (coregistered to PreopMRI). OSIRIX METHOD
      - Load co-registered Preop CT back into Osirix to create surface
      - Plugins>Database>Nifti to DICOM, select rct_[SUBJECT_ID].nii [Osirix Plugin](http://deqiang.webege.com/software/OsirixPlugins/NiftiToDICOM.html)
      - Double click on image in series to bring up larger viewer (agree when prompted)
      - 3D Viewer>3D Surface Rendering
      - Generally, move Resolution past halfway and set Pixel Value to 1400.	Adjust Pixel Value until just the skull is visible
      - Once complete, click Export 3D-SR on the top-right and select Export as Wavefront (.obj)
      -	Create CT_reg folder in the Freesurfer [SUBJECT_ID]_FS folder, and export as [SUBJECT_ID]_Bone.obj

#### Cortical Reconstruction
 
     - Prepare Surfaces for Localizer, Run Reconstruct Surfaces in dbslocs.m (This step can take 30 minutes or longer).

#### Fiducial Localizer

     1.	Run Fiducial Localizer
     2.	Open Image rpreopct.nii
     3.	Identify and mark pin tips
     4.	Save as PinTips.mat in Electrode_locations in Freesurfer folder
     5.	Open Image postopmri.nii or rpostopct.nii (Whichever image contains postop electrode location)
     6.	Identify and mark depth electrodes
          a.	Mark the tract every 2 slices on both slides
          b.	Try to use same reference for all markings
     7.	Save as depthelectrodes.mat in Electrode_locations in Freesurfer folder
     
####  Strip Electrode Localizer

    1.	Run Strip Localizer
          a.	To load all surfaces/ landmarks, click File>Load>Load All
               i.	To load individual surfaces/ landmarks:
                    1.	File>Load>Cortical Reconstruction and select cortex.mat in the subject’s directory
                    2.	File>Load>Skull Reconstruction and select skull.mat in the CT_reg directory of the subject’s directory
                    3.	File>Load>Cortical Hull and load your hull.mat in the subject’s directory
                    4. File>Load>Skull Fiducials and load PinTips.mat in the Electrode_locations folder of the subject’s directory
                    5.	File>Load>Electrode Locations and select depthelectrodes.mat in the Electrode_locations folder of the subject’s directory
          b.	File>Load>Fluoro Image located in the Fluoro folder in the subject’s directory
               i.	Image>Flip Fluoro Horizontally – Performed for all images to apply appropriate parallax effect (emitter on the left; detector on the right)
          c.	Align Skull/MRI with Fluoro
               i.	Optimize the following parameters:
                    1.	Depth DBS electrodes to fluoro depth electrodes/guide tube
                    2. CT skull to skull visible on the fluoroscopic image
                    3.	Pin tip locations to stereotactic frame in fluoro
                         a.	If pin tips are not visible on fluoroscopic image, ensure that they the CT locations are also not on the fluoro image
                    4.	Adjust the degree of parallax effect (default: head placed in the middle of the C-arm)
               ii.	Surface/ landmark visibility can be adjusted under Transparency
          d.	Once position is finalized:
               i.	Select the side of the ECoG electrodes under Electrode Side (i.e. Left or Right)
               ii.	Click Mark Electrodes
               iii.	Using standard cursor mode (IMPORTANT), click on each strip electrode visible on fluoro
               iv.	Marking should appear after calculation

     2.	Save electrode coordinates
          a.	File>Export>Electrode Coordinates
          b.	Navigate to your Electrode_locations 
          c.	Electrode locations will be saved in a CortElecLoc.mat file

#### Tips and Troubleshooting

     -	Check spelling and capitalization
     -	Remember to initialize
     -	Have a check list of steps done and for which patients
     -	Don’t move Fluoro, move brain space
     -	Remove cortex, cortical hull, and turn skull down to a minimal amount
     -	Use parallax numbers
     -	Save camera positions before marking electrodes
     -	Left is Red, Right is Blue
     -	Use No Principal Axis for orienting
     -	Make sure all camera tools are turned off before marking electrodes
     -	Electrodes are 6, 28, and 54 contact
     -	Mark electrodes on the correct side
     -	If contacts are not visible use best judgement
     -	Check by reloading cortex to see electrode placement
     -	Save your work into a separate file for comparison
     
## References
Randazzo, M. J., Kondylis, E. D., Alhourani, A., Wozny, T. A., Lipski, W. J., Crammond, D. J., & Richardson, R. M. (2016). Three-dimensional localization of cortical electrodes in deep brain stimulation surgery from intraoperative fluoroscopy. Neuroimage, 125, 515-521. https://www.ncbi.nlm.nih.gov/pubmed/26520771

## Contributors

* Stathis Kondylis
* Mike Randazzo
* Witold Lipski
* Ari Kappel
* Steven Lo
__________________________________________________________________________________
     Copyright (C) 2017 University of Pittsburgh, Brain Modulation Lab
