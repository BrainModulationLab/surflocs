function [Flname, Flpath] = dbs_getfluoroname

% small function determining the location and name of fluoro.tiff
% Should be in root patient directory, only .tif in folder.
ptroot = dbs_getrecentptfolder;
Flpath = [ptroot,'/'];

files = dir(ptroot);
files = cat(2,{files(:).name});
Flname = char(files(find(~cellfun(@isempty,strfind(files,'.tif')))));

end