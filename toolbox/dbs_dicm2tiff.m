function dbs_dicm2tiff(options)
% USAGE:
% dicm2tiff('Image1.dcm')
[pathname] = char(dbs_uigetdir(options.uipatdirs,'Choose Folder with Fluoro''s'));
[sub,files] = dbs_subdir(pathname);
if isempty(files)
    pathname = char(sub);
    [~,files] = dbs_subdir(char(pathname));
end
files = files(~cellfun(@isempty,strfind(files,'.dcm')));
% filenames = cellfun(@(x) (x(1:cell2mat(strfind(files,'.'))-1)), files,'UniformOutput',false); %remove extension
filenames = cellfun(@(x) (x(1:strfind(files{1},'.')-1)), files,'UniformOutput',false); %remove extension
mkdir(fullfile(pathname,'tiff'))
for i = 1:length(files)
    fluoro = dicomread(char(fullfile(pathname,files{i}))); %.dcm
    %     figure;
    %     imshow(fluoro)
    %     axis xy
    imwrite(fluoro,fullfile(pathname,'tiff',[filenames{i} '.tiff']));
end
end