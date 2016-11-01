function dbs_storefsui(handles)

try
chooseboxname=get(handles.fsdir_choosebox,'String');
catch
    return
end
% determine if patientfolder is set
switch chooseboxname
    case 'Choose Freesurfer Directory'
        outdir=[dbs_getroot];
    otherwise
        if strcmp(chooseboxname(1:8),'Multiple')
                    outdir=[dbs_getroot];

        else
        outdir=[get(handles.fsdir_choosebox,'String'),filesep];
        end
end

try % only works when calling from core dbs
updatestatus(handles);
end
options=dbs_handles2options(handles);
try save([outdir,'dbs_ui'],'-struct','options'); end