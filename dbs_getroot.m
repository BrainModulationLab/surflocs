function root=dbs_getroot

% small function determining the location of the dbs root directory.
if isdeployed
    errordlg(ctfroot);
    root=[ctfroot,'dbslocs'];
else
    root=[fileparts(which('dbslocs.m')),filesep];
end