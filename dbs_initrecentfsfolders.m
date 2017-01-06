function dbs_initrecentfsfolders(handles,fssub)

if ~exist('fssub','var')
    fssub='freesurfer';
end

dbsroot=dbs_getroot;
try
    load([dbsroot,'dbs_recentfsfolders.mat']);
catch
    fullrfs={['No recent ',fssub,' found']};
end
save([dbsroot,'dbs_recentfsfolders.mat'],'fullrfs');
dbs_updaterecentfsfolder(handles,fssub);