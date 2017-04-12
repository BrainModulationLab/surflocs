function dbs_getfsui(handles)



% determine if patientfolder is set
switch get(handles.fsdir_choosebox,'String')
    case {'Choose Freesurfer Directory','Multiple'}
        outdir=[dbs_getroot];
    otherwise
        outdir=get(handles.fsdir_choosebox,'String');
end
try

options=load([outdir,'dbs_ui']);
dbs_options2handles(options,handles); % update UI
end