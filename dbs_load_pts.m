function dbs_load_pts(handles,uipatdir,patsub)

if ~exist('patsub','var')
    patsub='patients';
end

if length(uipatdir)>1
    set(handles.patdir_choosebox,'String',['Multiple (',num2str(length(uipatdir)),')']);
    set(handles.patdir_choosebox,'TooltipString',dbs_strjoin(uipatdir,', '));
else
    set(handles.patdir_choosebox,'String',uipatdir{1});
    set(handles.patdir_choosebox,'TooltipString',uipatdir{1});
end

% store patient directories in figure


setappdata(handles.dbsfigure,'uipatdir',uipatdir);
try
dbs_switchctmr(handles);
end

dbs_getptui(handles); % update ui from patient
dbs_storeptui(handles); % save in pt folder
dbs_addrecentpatient(handles,uipatdir,['Recent ',patsub,':'],patsub);