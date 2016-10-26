function dbs_addrecentfsfolder(handles,uifsdir,chosenix,fssub)
dbsroot=dbs_getroot;
if ~exist('fssub','var')
    fssub='freesurfer';
end
if ~exist([dbsroot,'dbs_recentfsfolders.mat']);
    fullrpts = dbsroot;
else
    load([dbsroot,'dbs_recentfsfolders.mat']);
end

if strcmp(fullrpts,['No recent ',fssub,' found'])
    fullrpts={};
end

if ~exist('chosenix','var')
    try
        chosenix=fullrpts{get(handles.recentpts,'Value')};
    catch
        chosenix=['Recent ',fssub,':'];
    end
end

try
fullrpts=[uifsdir';fullrpts];
catch % calls from lead_group could end up transposed
fullrpts=[uifsdir;fullrpts];    
end

[fullrpts]=unique(fullrpts,'stable');
if length(fullrpts)>10
    
   fullrpts=fullrpts(1:10);
end
[~,nuchosenix]=ismember(chosenix,fullrpts);
save([dbsroot,'dbs_recentfsfolders.mat'],'fullrpts');

dbs_updaterecentfsfolder(handles,fssub,nuchosenix);
