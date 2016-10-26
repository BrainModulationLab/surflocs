function dbs_initrecentfsfolders(handles,fssub)

if ~exist('fssub','var')
    fssub='freesurfer';
end

dbsroot=dbs_getroot;
try
    load([dbsroot,'dbs_recentfsfolders.mat']);
catch
    fullrpts={['No recent ',fssub,' found']};
end
save([dbsroot,'dbs_recentfsfolders.mat'],'fullrpts');
dbs_updaterecentfsfolder(handles,fssub);