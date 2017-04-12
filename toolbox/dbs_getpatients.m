function dbs_getpatients(handles)


p='/'; % default use root
try
p=pwd; % if possible use pwd instead (could not work if deployed)
end
try % finally use last patient parent dir if set.
dbsroot=dbs_getroot;
if exist([dbsroot,'dbs_recentpatients.mat'])
    load([dbsroot,'dbs_recentpatients.mat']);
    p=fileparts(fullrpts{1});
else
end
end

uipatdir=dbs_uigetdir(p,'Please choose patient folder(s)...');

if isempty(uipatdir)
    return
end

dbs_load_pts(handles,uipatdir);