function dbs_addrecentfsfolder(handles,uifsdir,chosenix,fssub)
dbsroot=dbs_getroot;
if ~exist('fssub','var')
    fssub='freesurfer';
end
if ~exist([dbsroot,'dbs_recentfsfolders.mat']);
    fullrfs = dbsroot;
else
    load([dbsroot,'dbs_recentfsfolders.mat']);
end

if strcmp(fullrfs,['No recent ',fssub,' found'])
    fullrfs={};
end

if ~exist('chosenix','var')
    try
        chosenix=fullrfs{get(handles.recentpts,'Value')};
    catch
        chosenix=['Recent ',fssub,':'];
    end
end

try
fullrfs=[uifsdir';fullrfs];
catch % calls from lead_group could end up transposed
fullrfs=[uifsdir;fullrfs];    
end

[fullrfs]=unique(fullrfs,'stable');
if length(fullrfs)>10
    
   fullrfs=fullrfs(1:10);
end
[~,nuchosenix]=ismember(chosenix,fullrfs);
save([dbsroot,'dbs_recentfsfolders.mat'],'fullrfs');

dbs_updaterecentfsfolder(handles,fssub,nuchosenix);
