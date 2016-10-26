function dbs_updaterecentfsfolder(handles,fssub,nuchosenix)
if ~exist('fssub','var')
    fssub='freesurfer';
end
dbsroot=dbs_getroot;
load([dbsroot,'dbs_recentfsfolders.mat']);
for i=1:length(fullrpts)
    [~,fullrpts{i}]=fileparts(fullrpts{i});
end
fullrpts=[{['Recent ',fssub,':']};fullrpts];
set(handles.recentfs,'String',fullrpts);
if exist('nuchosenix','var')
   set(handles.recentfs,'Value',nuchosenix+1); 
end