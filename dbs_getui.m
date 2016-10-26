function dbs_getui(handles)



% determine if patientfolder is set
switch get(handles.patdir_choosebox,'String')
    case {'Choose Patient Directory','Multiple'}
        outdir=[dbs_getroot];
    otherwise
        outdir=get(handles.patdir_choosebox,'String');
end
try

options=load([outdir,'dbs_ui']);
dbs_options2handles(options,handles); % update UI
end