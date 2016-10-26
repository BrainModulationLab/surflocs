function dbs_getfsfolder(handles)


p='/'; % default use root
try
p=pwd; % if possible use pwd instead (could not work if deployed)
end
try % finally use last patient parent dir if set.
dbsroot=dbs_getroot;
if exist([dbsroot,'dbs_recentfsfolders.mat'])
    load([dbsroot,'dbs_recentfsfolders.mat']);
    p=fileparts(fullrpts{1});
else
end
end

uifsdir=dbs_uigetdir(p,'Please choose freesurfer folder(s)...');

if isempty(uifsdir)
    return
end

dbs_load_fs(handles,uifsdir);