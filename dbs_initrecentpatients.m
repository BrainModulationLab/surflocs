function dbs_initrecentpatients(handles,patsub)

if ~exist('patsub','var')
    patsub='patients';
end

dbsroot=dbs_getroot;
try
    load([dbsroot,'dbs_recentpatients.mat']);
catch
    fullrpts={['No recent ',patsub,' found']};
end
save([dbsroot,'dbs_recentpatients.mat'],'fullrpts');
dbs_updaterecentpatients(handles,patsub);