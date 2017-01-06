function dbs_updaterecentfsfolder(handles,fssub,nuchosenix)
if ~exist('fssub','var')
    fssub='freesurfer';
end
dbsroot=dbs_getroot;
load([dbsroot,'dbs_recentfsfolders.mat']);
for i=1:length(fullrfs)
    [~,fullrfs{i}]=fileparts(fullrfs{i});
end
fullrfs=[{['Recent ',fssub,':']};fullrfs];
try
    set(handles.recentfs,'String',fullrfs);
catch
    return
end
if exist('nuchosenix','var')
   set(handles.recentfs,'Value',nuchosenix+1); 
end