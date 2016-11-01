function [ptroot] = dbs_getrecentptfolder

% small function determining the location of the fs root directory.
root = dbs_getroot;
load(fullfile(root,'dbs_recentpatients.mat'))
ptroot = fullrpts{1};

end
