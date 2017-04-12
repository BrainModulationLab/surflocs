function dbs_localizefids(options)
% INPUT:
%   rpreopct: full filename to registered preop ct .nii image for recon
%
%

if ~isstr(rpreopct)
    error('Input must be a string')
end

nii = load_nii(fullfile(options.uipatdirs,'postopmri.nii');

if nargin==1
    figtit=rpreopct;
else
    figtit='';
end

% figure;
isp=figure('color','k','Name',figtit,'NumberTitle','off','MenuBar','none','DockControls','off','ToolBar','none');

sno = size(nii.img);
sno = size(nii.img);  % image size
sno_a = sno(3);  % number of axial slices
S_a = round(sno_a/2);
sno_s = sno(2);  % number of sagittal slices
S_s = round(sno_s/2);
sno_c = sno(1);  % number of coronal slices
S_c = round(sno_c/2);
S = S_a;
sno = sno_a;

% Get/Set Window Handles
FigPos = get(gcf,'Position');
S_Pos = [50 20 uint16(FigPos(3)-150)+1 20];
Stxt_Pos = [50 90 uint16(FigPos(3)-100)+1 15];
Wtxt_Pos = [20 20 60 20];
Wval_Pos = [75 20 60 20];
Ltxt_Pos = [140 20 45 20];
Lval_Pos = [180 20 60 20];
BtnStPnt = uint16(FigPos(3)-210)+1;
if BtnStPnt < 360
    BtnStPnt = 360;
end
Btn_Pos = [BtnStPnt 20 80 20];
ChBx_Pos = [BtnStPnt+90 20 100 20];
Vwtxt_Pos = [255 20 35 20];
VAxBtn_Pos = [490 20 15 20];
VSgBtn_Pos = [510 20 15 20];
VCrBtn_Pos = [530 20 15 20];


% global InitialCoord;
MinV = 0;
MaxV = dbs_nanmax(nii.img(:));
LevV = (double( MaxV) + double(MinV)) / 2;
Win = double(MaxV) - double(MinV);
WLAdjCoe = (Win + 1)/1024;
FineTuneC = [1 1/16];    % Regular/Fine-tune mode coefficients
SFntSz = 9;
LFntSz = 10;
WFntSz = 10;
VwFntSz = 10;
LVFntSz = 9;
WVFntSz = 9;
BtnSz = 10;
ChBxSz = 10;

[Rmin Rmax] = WL2R(Win, LevV);

% hdl_im = axes('position',[0,0,1,1]);
% set(0,'CurrentFigure',isp);
MainImage = 1;
XImage=1:size(nii.img,1);
YImage=1:size(nii.img,2);

if isa(nii.img,'uint8')
    MaxV = uint8(Inf);
    MinV = uint8(-Inf);
    LevV = (double( MaxV) + double(MinV)) / 2;
    Win = double(MaxV) - double(MinV);
    WLAdjCoe = (Win + 1)/1024;
elseif isa(nii.img,'uint16')
    MaxV = uint16(Inf);
    MinV = uint16(-Inf);
    LevV = (double( MaxV) + double(MinV)) / 2;
    Win = double(MaxV) - double(MinV);
    WLAdjCoe = (Win + 1)/1024;
elseif isa(nii.img,'uint32')
    MaxV = uint32(Inf);
    MinV = uint32(-Inf);
    LevV = (double( MaxV) + double(MinV)) / 2;
    Win = double(MaxV) - double(MinV);
    WLAdjCoe = (Win + 1)/1024;
elseif isa(nii.img,'uint64')
    MaxV = uint64(Inf);
    MinV = uint64(-Inf);
    LevV = (double( MaxV) + double(MinV)) / 2;
    Win = double(MaxV) - double(MinV);
    WLAdjCoe = (Win + 1)/1024;
elseif isa(nii.img,'int8')
    MaxV = int8(Inf);
    MinV = int8(-Inf);
    LevV = (double( MaxV) + double(MinV)) / 2;
    Win = double(MaxV) - double(MinV);
    WLAdjCoe = (Win + 1)/1024;
elseif isa(nii.img,'int16')
    MaxV = int16(Inf);
    MinV = int16(-Inf);
    LevV = (double( MaxV) + double(MinV)) / 2;
    Win = double(MaxV) - double(MinV);
    WLAdjCoe = (Win + 1)/1024;
elseif isa(nii.img,'int32')
    MaxV = int32(Inf);
    MinV = int32(-Inf);
    LevV = (double( MaxV) + double(MinV)) / 2;
    Win = double(MaxV) - double(MinV);
    WLAdjCoe = (Win + 1)/1024;
elseif isa(nii.img,'int64')
    MaxV = int64(Inf);
    MinV = int64(-Inf);
    LevV = (double( MaxV) + double(MinV)) / 2;
    Win = double(MaxV) - double(MinV);
    WLAdjCoe = (Win + 1)/1024;
elseif isa(nii.img,'logical')
    MaxV = 0;
    MinV = 1;
    LevV =0.5;
    Win = 1;
    WLAdjCoe = 0.1;
else
    MaxV = 0;
    MinV = 1;
    LevV =0.5;
    Win = 1;
    WLAdjCoe = 0.1;
end


% SHOW IMAGE
% for i = 1:size(nii.img,3)
% lvalhand = uicontrol('Style', 'edit','Position', Lval_Pos,'String',sprintf('%6.0f',LevV), 'BackgroundColor', [1 1 1], 'FontSize', LVFntSz,'Callback', @WinLevChanged);
% wvalhand = uicontrol('Style', 'edit','Position', Wval_Pos,'String',sprintf('%6.0f',Win), 'BackgroundColor', [1 1 1], 'FontSize', WVFntSz,'Callback', @WinLevChanged);
% set(ImHndl,'ButtonDownFcn', @mouseClick);
% ImHndl = imshow(BW{i})
% Resize Figure: see line 20
try % image toolbox
    ImHndl=imshow(squeeze(nii.img(XImage,YImage,S,MainImage)), [Rmin Rmax]);
catch
    ImHndl=imagesc(squeeze(nii.img(XImage,YImage,S,MainImage)), [Rmin Rmax]);
end;
set(gcf,'Position',[134   232   959   742])% to use medium window size; % dbs_maximize(isp); %to maximize window
set(gcf,'WindowScrollWheelFcn',@mouseScroll);

% for i = 1:size(nii.img,3)
% level{i} = graythresh(nii.img(:,:,i));
% BW{i} = imbinarize(nii.img(:,:,i),level{i});
% end

% RI = imref2d(size(nii.img));
% imshow(BW{i},RI)


% -=< Figure resize callback function >=-
    function figureResized(object, eventdata)
        FigPos = get(gcf,'Position');
        S_Pos = [50 45 uint16(FigPos(3)-100)+1 20];
        Stxt_Pos = [50 65 uint16(FigPos(3)-100)+1 15];
        BtnStPnt = uint16(FigPos(3)-210)+1;
        if BtnStPnt < 360
            BtnStPnt = 360;
        end
        Btn_Pos = [BtnStPnt 20 80 20];
        ChBx_Pos = [BtnStPnt+90 20 100 20];
        if sno > 1
           % set(shand,'Position', S_Pos);
        end
        set(stxthand,'Position', Stxt_Pos);
        set(ltxthand,'Position', Ltxt_Pos);
        set(wtxthand,'Position', Wtxt_Pos);
        set(lvalhand,'Position', Lval_Pos);
        set(wvalhand,'Position', Wval_Pos);
        set(Btnhand,'Position', Btn_Pos);
        set(ChBxhand,'Position', ChBx_Pos);
        set(Vwtxthand,'Position', Vwtxt_Pos);
        set(VAxBtnhand,'Position', VAxBtn_Pos);
        set(VSgBtnhand,'Position', VSgBtn_Pos);
        set(VCrBtnhand,'Position', VCrBtn_Pos);
    end

% -=< Slice slider callback function >=-
    function SliceSlider (hObj,event, nii)
        S = round(get(hObj,'Value'));
        set(ImHndl,'cdata',squeeze(nii.img(:,:,S,:)))
        caxis([Rmin Rmax])
        if sno > 1
            %set(stxthand, 'String', sprintf('Slice# %d / %d',S, sno));
        else
            %set(stxthand, 'String', '2D image');
        end
    end

% -=< Mouse scroll wheel callback function >=-
    function mouseScroll (object, eventdata)
        UPDN = eventdata.VerticalScrollCount;
        S = S - UPDN;
        if (S < 1)
            S = 1;
        elseif (S > sno)
            S = sno;
        end
        if sno > 1
            %   set(shand,'Value',S);
            %            set(stxthand, 'String', sprintf('Slice# %d / %d',S, sno));
        else
            %           set(stxthand, 'String', '2D image');
        end
        set(ImHndl,'cdata',squeeze(nii.img(XImage,YImage,S,MainImage)))
    end

% -=< Window and level to range conversion >=-
    function [Rmn Rmx] = WL2R(W,L)
        Rmn = L - (W/2);
        Rmx = L + (W/2);
        if (Rmn >= Rmx)
            Rmx = Rmn + 1;
        end
    end

    end