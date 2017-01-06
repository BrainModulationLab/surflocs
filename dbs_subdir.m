function [sub,fls] = dbs_subdir(CurrPath)
%   DBS_SUBDIR  lists all subfolders and files under given folder
%    
%   DBS_SUBDIR
%        returns all subfolder under current path.
%
%   P = DBS_SUBDIR('directory_name') 
%       stores all subfolders under given directory into a variable 'P'
%
%   [P F] = DBS_SUBDIR('directory_name')
%       stores all subfolders under given directory into a
%       variable 'P' and all filenames into a variable 'F'.
%       use sort([F{:}]) to get sorted list of all filenames.
%
%   See also DIR, CD

%   Original author:  Elmar Tarajan [Elmar.Tarajan@Mathworks.de]

if nargin == 0
   CurrPath = pwd;
end
if nargout == 1
   sub = subfolder(CurrPath,'');
else
   [sub,fls] = subfolder(CurrPath,'');
end

%------------------------------------------------
function [sub,fls] = subfolder(CurrPath,sub)
    tmp = dir(CurrPath);
    tmp = tmp(~ismember({tmp.name},{'.' '..' '.DS_Store'}));
    fls = {tmp(~[tmp.isdir]).name}; %files in current directory
    for i = {tmp([tmp.isdir]).name}  %cellfun(@(x) x==0, {tmp.isdir})
        sub{end+1} = [CurrPath '/' i{:}]; % folders in CurrPath
    end
end
end