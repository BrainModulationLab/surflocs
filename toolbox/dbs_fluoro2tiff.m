function dbs_fluoro2tiff(fName,path2file)

% dcm to tiff
fluoro = dicomread(fullfile(fName,path2file));
figure;
imshow(fluoro)
% axis xy
pause
imwrite(fluoro,'fluoro.tiff');

end