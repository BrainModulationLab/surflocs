function dbs_load_fs(handles,uifsdir,fssub)

if ~exist('fssub','var')
    fssub='freesurfer';
end

if length(uifsdir)>1
    set(handles.fsdir_choosebox,'String',['Multiple (',num2str(length(uifsdir)),')']);
    set(handles.fsdir_choosebox,'TooltipString',dbs_strjoin(uifsdir,', '));
else
    set(handles.fsdir_choosebox,'String',uifsdir{1});
    set(handles.fsdir_choosebox,'TooltipString',uifsdir{1});
end

% store patient directories in figure


setappdata(handles.dbsfigure,'uifsdir',uifsdir);
try
dbs_switchctmr(handles);
end

dbs_getui(handles); % update ui from patient
dbs_storeui(handles); % save in pt folder
dbs_addrecentfsfolder(handles,uifsdir,['Recent ',fssub,':'],fssub);