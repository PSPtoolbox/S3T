%fname = '../../data/Experiment 1_iglu spontaneous.tif';
%fname = '../../data/data_endoscope.tif';

function [A, fname, FileName, PathName, U, S, V, error]=loadTiff(fname,fastload,frameNumbers)
%set Fastload Default value
if nargin<2
   fastload=0;
end
error=0;
U=nan;
S=nan;
V=nan;
%fname = '../../data/Experiment 5_SyG 10AP.tif';
global defaultDir
if nargin<1 || isempty(fname)
    [FileName,PathName] = uigetfile('*.tif','Select the Tiff file',defaultDir);
    fname = [PathName FileName];
end
bkslsh = strfind(fname,'\');
if (isempty(bkslsh))
    bkslsh = strfind(fname,'/');
end
FileName = fname(bkslsh(end)+1:end);
PathName = fname(1:bkslsh(end));
disp(['Loading: ' fname]);
%%

extra=1; % Provides some animation. Avg movie, avg signal, ...


if extra==1
%imagesc(imread(fname, 1));
title('Loading ....')
drawnow();
end

if fastload
    if extra==1 
    title(['fastLoading .../'])%num2str(num_images)])
    end
    [A, U, S, V] = fastLoadTiff(fname);
    warning('Using fastload');
    extra=0; %Don't animate with fastload.
    num_images=size(A,3); % If eigs where calculated on a part of the movie, and the 

else
    info = imfinfo(fname);
num_images = numel(info);
A=zeros(info(1).Height,info(1).Width,num_images);

for k = 1:num_images
    bbb=imread(fname, k);
    if (size(bbb,3))==1
        A(:,:,k) = bbb;
    else
        disp(['Unsupporte file format: ']);
        disp(['     ' fname] );
        error=1;
        A=nan;
    end
    if extra==1 && mod(k,100)==0
        imagesc(A(:,:,k));
        title(['Loading ' num2str(k) '/'  num2str(num_images)])
        drawnow();
    end
end

end
%% You want more?

if extra
    %disp('Extra stuff.')
    %% Calculate Average
    title('Loading Done');
    Avg= mean(A,3);
    %figure;
    subplot(4,4,[2:3,6:7])
    imagesc(squeeze(Avg))
    
    %% Look at average reponse:
    for k = 1:num_images
        ss(k) = sum(sum(A(:,:,k)-Avg));
    end
    %fig=figure;
    subplot(4,4,10);
    plot(ss);
   % axis off    
    savesubplot(4,4,10,[fname '_temp']);
    
    mpa = colormap(hot);
    imwrite((Avg-min(min(Avg)))*1.0/(max(max(Avg))-min(min(Avg)))*128,mpa,[fname '_avg.png']);
    %%
    %saveas(gca,[fname '2.png'])
end
