function dbs_rcpatientscallback(handles)

if get(handles.recentpts,'Value')==1
    return
end
dbsroot=dbs_getroot;
load([dbsroot,'dbs_recentpatients.mat']);
if iscell(fullrpts)
fullrpts=fullrpts(get(handles.recentpts,'Value')-1);
end

if strcmp('No recent patients found',fullrpts)
   return 
end


dbs_load_pts(handles,fullrpts);