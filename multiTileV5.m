fname='Y:\data\Michiel\Protocol1120171121_161207.tif';
txtname='Y:\data\Michiel\Protocol1120171121_161207.txt';
%%
fname= 'Y:\data\Michiel\Protocol1420171121_162003.tif';
txtname  = 'Y:\data\Michiel\Protocol1420171121_162003.txt';
%%
fname= 'Y:\data\Michiel\Protocol1220171121_161824.tif';
txtname  = 'Y:\data\Michiel\Protocol1220171121_161824.txt';

%%
fname= 'L:\beerse\all\Public\Exchange\Michiel\post\Protocol13820180306_145832_20180306_150051\Protocol13820180306_145832_tt0000.tif';
txtname  = 'L:\beerse\all\Public\Exchange\Michiel\post\Protocol13820180306_145832_20180306_150051\Protocol13820180306_145832.txt';

%%
fname= 'F:\share\data\Michiel\photoshoot\NS_8_20190507_160436\NS_8_tt0000.tif';
txtname  = 'F:\share\data\Michiel\photoshoot\NS_8_20190507_160436\NS_8.txt';


%%
fname= 'F:\share\data\Michiel\photoshoot\NS_7_20190507_155510\NS_7_tt0000.tif';
txtname  = 'F:\share\data\Michiel\photoshoot\NS_7_20190507_155510\NS_7.txt';


%%

fname= 'F:\share\data\Michiel\photoshoot\NS_920190507_162402_20190507_172619\NS_920190507_162402_m000000_tt0000.tif';
txtname  = 'F:\share\data\Michiel\photoshoot\NS_920190507_162402_20190507_172619\NS_920190507_162402.txt';
%% x10

fname1= 'F:\share\data\Michiel\photoshoot\stimx10\NS_68_20190514_175204\NS_68_tt0000.tif';
fname2= 'F:\share\data\Michiel\photoshoot\stimx10\NS_68_20190514_175204\NS_68_tt0001.tif';
txtname  = 'F:\share\data\Michiel\photoshoot\stimx10\NS_68_20190514_175204\NS_68.txt';

%% x10 30

fname1= 'F:\share\data\Michiel\photoshoot\stimx10-w30\NS_73_20190514_180551\NS_73_tt0000.tif';
fname2= 'F:\share\data\Michiel\photoshoot\stimx10-w30\NS_73_20190514_180551\NS_73_tt0001.tif';
txtname  = 'F:\share\data\Michiel\photoshoot\stimx10-w30\NS_73_20190514_180551\NS_73.txt';

%%

fname1= 'F:\share\data\Michiel\photoshoot\stimx10-w31\NS_81_20190514_182407\NS_81_tt0000.tif';
fname2= 'F:\share\data\Michiel\photoshoot\stimx10-w31\NS_81_20190514_182407\NS_81_tt0001.tif';
txtname  = 'F:\share\data\Michiel\photoshoot\stimx10-w31\NS_81_20190514_182407\NS_81.txt';
%%

fname1= 'F:\share\data\Michiel\photoshoot\stimx10-w32\NS_83_20190514_183520\NS_83_tt0000.tif';
fname2= 'F:\share\data\Michiel\photoshoot\stimx10-w32\NS_83_20190514_183520\NS_83_tt0001.tif';
txtname  = 'F:\share\data\Michiel\photoshoot\stimx10-w32\NS_83_20190514_183520\NS_83.txt';

%%


fname= 'F:\share\data\Michiel\photoshoot\stimulatedx40\NS_60_20190514_164245\NS_60_m000000_tt0000.tif';
txtname  = 'F:\share\data\Michiel\photoshoot\stimulatedx40\NS_60_20190514_164245\NS_60.txt';

%%

fname1= 'F:\share\data\Michiel\photoshoot\stimx60\NS_66.tif';
txtname  = 'F:\share\data\Michiel\photoshoot\stimx60\NS_66.txt';

%% open the text file
fid = fopen(txtname);
S = fscanf(fid,'%s');       
fclose(fid);
%%
xpos=[];ypos=[];
 pos=strfind(S,['Fields' num2str(32768)]);
 for L=1:length(pos)  
       xpos(L)=str2num(S(pos(L)+10+(1:10)));
       ypos(L)=str2num(S(pos(L)+22+(1:11)));
 end

 %%
 %data=A;
 %%
mx=min(xpos);
my=min(ypos);
dx=max(xpos)-min(xpos)
dy=max(ypos)-min(ypos)

%%
[data1 fname]=loadTiff(fname1);
%%
switch 'x10'
case 'x10'
[data2 fname]=loadTiff(fname2);
%%
for k=0:99
    data(:,:,k*20+(1:15))=data1(:,:,k*15+(1:15));
    data(:,:,k*20+(16:20))=data2(:,:,k*5+(1:5));
end
case 'x60'
data=data1;

end
%% flat field correction
switch '10x'
    case '10x'
        Z=mean(data,3);
        figure; imagesc(Z);
         D=Z/norm(Z)*512*512;
        E=1./D;
     case '60x'
        Z=mean(data,3);
        figure; imagesc(Z);
         D=Z/norm(Z)*512*512;
        E=1./D;
    case '40x'
        Z=zeros(512);
        for k = 1:1680
            k
            if 1
                PathName = 'F:\share\data\Michiel\photoshoot\NS_920190507_162402_20190507_172619';
                ppp='NS_920190507_162402_m';% 001679;% '_tt0003';
                FileName=[ num2str(1000000+k-1)];
                B=imread(fname, 1);
                
                for tt=18%0:19
                    ttnum=num2str(100+tt);
                    fname = [PathName '\' ppp FileName(2:end) '_tt00' ttnum(2:end) '.tif'];
                    B=imread(fname, 1);
                    Z=Z+double(B);
                end
            end
        end
        
        D=Z/norm(Z)*512*512;
        E=1./D;
end

%%
C=[];
switch '10x'
    case '10x'
        scx=1/1.6*1.0073;
        scy=1/1.6*1.0073;
    case '40x'        
        scx=1/0.407;
        scy=1/0.407;
     case '60x'
        scx=1/0.266666*1.0073;
        scy=1/0.266666*1.0073;
end
A=zeros(ceil(dy*scy)+512+512,ceil(dx*scx)+512+512,3);

%A=zeros(5*812,ceil(dx*scx)+512+512,1);
% 
% sc=1/0.266666666;
% sc=1/0.2;
% sc=1/1.66;

for k = 1:100%1681
    k
    if 0 %read each file separatly
        PathName = 'F:\share\data\Michiel\photoshoot\NS_920190507_162402_20190507_172619';
        PathName = 'F:\share\data\Michiel\photoshoot\stimulatedx40\NS_60_20190514_164245';
        ppp='NS_920190507_162402_m';% 001679;% '_tt0003';
         ppp='NS_60_m';
        FileName=[ num2str(1000000+k-1)];
  
        for tt=0:19
            ttnum=num2str(100+tt);
            fname = [PathName '\' ppp FileName(2:end) '_tt00' ttnum(2:end) '.tif'];
            B=double(imread(fname, 1));
            B=B.*E;
            C(:,tt+1)=B(:);
        end
        [U S V]=svd(double(C),'econ');
        %B=imread(fname, 1);
        %B=reshape(U(:,1)*S(1,1),[512,512]);
        
    else %read each frames from 1 file
        C=[];
        nframes=20; % frames Per field
        %  B=mean( data(:,:,(k-1)*nframes+(1:nframes)),3);
        for tt=1:nframes
            B=data(:,:,(k-1)*nframes+(tt));            
            B=B.*E;
            C(:,tt)=B(:);
        end
        [U, S, V]=svd(double(C),'econ');
%         U=mean(C,2);
%         S=1;
    end
    
    for ii=1:3%3
        B=reshape(U(:,ii)*S(ii,ii),[512,512]);
        
       alfa=3.5586;%� %atan(25/402)/pi*180
        B=abs(imrotate(B,alfa));%2.9 %atan(25/402)/pi*180
        [sBy, sBx]=size(B);
        
        
    
    %figure(1);imagesc(B);
    %pause(.1)
    %if k>192
    %    B=double(B)/3.33;
    %end
    [pR]=[1 0;0 1]*[xpos(k); ypos(k)];
    %[pR]=[cosd(alfa) -sind(alfa);sind(alfa) cosd(alfa)]*[xpos(k); ypos(k)];
    
    cy=floor((pR(2)-my)*scy);
    cx=floor((pR(1)-mx)*scx);
    
    
    %A(floor((ypos(k)-my)*sc)+(1:512),floor((xpos(k)-mx)*sc)+(1:512)) = 1/2*A(floor((ypos(k)-my)*sc)+(1:512),floor((xpos(k)-mx)*sc)+(1:512)) + 1/2*double(B)  ;  
    %A(cy+(1:512),cx+(1:512)) = (A(cy+(1:512),cx+(1:512)).*A(cy+(1:512),cx+(1:512))+double(B).*double(B))./(A(cy+(1:512),cx+(1:512))+double(B)+.0001)  ;  
    A(cy+(1:sBy),cx+(1:sBx),ii) = (A(cy+(1:sBy),cx+(1:sBx),ii).*A(cy+(1:sBy),cx+(1:sBx),ii)+double(B).*double(B))./(A(cy+(1:sBy),cx+(1:sBx),ii)+double(B)+.0001)  ;  
    
    %A(1:512,floor((xpos(k2)-mx)*3.75)+ddx+(1:512))=A(1:512,floor((xpos(k2)-mx)*3.75)+ddx+(1:512))+double(E);

    end  
end
%%
figure();
%imagesc(sqrt(abs(A(:,:,2)))*4e0);
imagesc(A(:,:,1)*4e0);

pause(.01);


%% OLD Read images
if 0
    info = imfinfo(fname);
    num_images = numel(info);
    A=zeros(info(1).Height,info(1).Width,num_images);
    for k = 1:num_images
        A(:,:,k) = imread(fname, k);
    end
end
%% OLD Concatenate the images:
if 0
    B=zeros(512*10,512*10);
    for k=0:9
        for j=0:9
            for i=1:30
                wx=1:512;
                B(wx+k*512,wx+j*512)=B(wx+k*512,wx+j*512)+A(:,:,i+j*30+k*30*10);
            end
        end
    end
end
%%
%figure;
image(A/60-4)

%% Export
jj=colormap('hot');
imwrite(A(:,:,1)/-730*75-4,jj,'wellNS669eigx10.png','bitdepth',8,'colormap','hot')
%%
imwrite(uint16(A(:,:,1)/730*7500-4),jj,'well29eigx60.tif')
