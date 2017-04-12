function dbs_addrecentpatient(handles,uipatdir,chosenix,patsub)
dbsroot=dbs_getroot;
if ~exist('patsub','var')
    patsub='patients';
end
if ~exist([dbsroot,'dbs_recentpatients.mat']);
    fullrpts = dbsroot;
else
    load([dbsroot,'dbs_recentpatients.mat']);
end

if strcmp(fullrpts,['No recent ',patsub,' found'])
    fullrpts={};
end

if ~exist('chosenix','var')
    try
        chosenix=fullrpts{get(handles.recentpts,'Value')};
    catch
        chosenix=['Recent ',patsub,':'];
    end
end

try
fullrpts=[uipatdir';fullrpts];
catch % calls from lead_group could end up transposed
fullrpts=[uipatdir;fullrpts];    
end

[fullrpts]=unique(fullrpts,'stable');
if length(fullrpts)>10
    
   fullrpts=fullrpts(1:10);
end
[~,nuchosenix]=ismember(chosenix,fullrpts);
save([dbsroot,'dbs_recentpatients.mat'],'fullrpts');

dbs_updaterecentpatients(handles,patsub,nuchosenix);
