function dbs_rcfscallback(handles)

if get(handles.recentfs,'Value')==1
    return
end
dbsroot=dbs_getroot;
load([dbsroot,'dbs_recentfsfolders.mat']);
if iscell(fullrfs)
    fullrfs=fullrfs(get(handles.recentfs,'Value')-1);
end

if strcmp('No recent patients found',fullrfs)
   return 
end


dbs_load_fs(handles,fullrfs);