function [filename, pathname, extension] = dbs_uigetfile(start_path, dialog_title)
%
% Syntax: 
%       [filename, pathname, extension] = dbs_uigetfile(start_path, dialog_title)
%
import javax.swing.JFileChooser;

if nargin == 0 || strcmp(start_path,'') % Allow a null argument.
    start_path = pwd;
end

jchooser = javaObjectEDT('javax.swing.JFileChooser', start_path);

jchooser.setFileSelectionMode(JFileChooser.FILES_AND_DIRECTORIES);
if nargin > 1
    jchooser.setDialogTitle(dialog_title);
end

jchooser.setMultiSelectionEnabled(true);

status = jchooser.showOpenDialog([]);

if status == JFileChooser.APPROVE_OPTION
    jFile = jchooser.getSelectedFiles();
    pathname{size(jFile, 1)}=[];
    for i=1:size(jFile, 1)
        [pathname, filename, extension] = fileparts(char(jFile(i).getAbsolutePath));
    end

elseif status == JFileChooser.CANCEL_OPTION
    pathname = [];
else
    error('Error occured while picking file.');
end


% [filename, pathname, filterindex] = uigetputfile_helper(0, varargin{:});
end 
