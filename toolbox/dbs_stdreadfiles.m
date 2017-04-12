function dbs_stdreadfiles(options)

% RUN FROM SUBJECT DIRECTORY
subjects = options.uifsdir;
fname = {'std.60.lh.pial.asc','std.60.rh.pial.asc'};
% 
% for i_subjects=1:length(subjects)

cd(fullfile(subjects{i_subjects},'SUMA'))
    
    for i = 1:length(fname)
        % Read in the faces and vertices
        num_vert_tri = dlmread([fname{i}],' ',[1 0 1 1]); %Reads in two numbers
        num_vert = num_vert_tri(1,1);
        num_tri = num_vert_tri(1,2);
        
        % Reading in vertices
        vert_pre = dlmread([fname{i}],' ',[2 0 num_vert+1 4]);
        vert(:,:,i) = vert_pre(:,1:2:5);
        
        % Reading in tri
        tri(:,:,i) = dlmread([fname{i}],' ',[num_vert+2 0 num_vert+num_tri+1 2]);
        
        tri(:,:,i)=tri(:,:,i)+1;
    end
    
    cortex.vert = [vert(:,:,1);vert(:,:,2)];
    cortex.faces = [tri(:,:,1);(tri(:,:,2) + length(vert(:,:,1)))];
    
    save('cortex_std_60.mat','cortex');

    cd ../..
end


%%
%READ IN MNI

%[cortex.vert,cortex.faces] = read_surf('std.60.rh.pial');

%cortex.faces = cortex.faces+1;

% Reading in MRI parameters
%f=MRIread('./T1.nii');

%%

% % Display cortex
% 
% % Reading in MRI parameters
f=MRIread('../mri/T1.mgz');
 
% Translating into the appropriate space
for k=1:size(cortex.vert,1)
    a=f.vox2ras/f.tkrvox2ras*[cortex.vert(k,:) 1]';
    cortex.vert(k,:)=a(1:3)';
end

figure;
Hp = patch('vertices',cortex.vert,'faces',cortex.faces(:,[1 3 2]),'facecolor',[.65 .65 .65],'edgecolor','none');
        camlight('headlight','infinite');
        axis off;
        axis equal
        set(gca,'DataAspectRatioMode','manual');
        set(gca,'PlotBoxAspectRatioMode','manual');
end
