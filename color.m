%enter 'pkg load image' in the octave command windows
%to load the required image processing package.
%----------------------------------------------------------------------
%get images
I=imread('ori.jpg');
I=im2double(I);
%----------------------------------------------------------------------
%convert to HSV
Ihsv=rgb2hsv(I);
Ih=Ihsv(:,:,1);
Is=Ihsv(:,:,2);
Iv=Ihsv(:,:,3);
%----------------------------------------------------------------------
%get the mask for blue primary which is at 240 degree in hsv
bdeg=240/360;
Im=abs(Ih-bdeg);
%since the distance cannot be larger then 180 degree,
%the values greater than 0.5 should be subtracted from 1
Ii=Im>0.5;
Im=abs(Ii-Im);
%--------------------------------------------------------------------------
%get the global image threshold using Otsu's method
Ith=graythresh(Im);
%--------------------------------------------------------------------------
%make it binary (black and white)
Im=im2bw(Im,Ith);
imshow(Im);%show the mask
Im=cat(3,Im,Im,Im);
%--------------------------------------------------------------------------
%define an angle to rotate H in degree
a=240;
%convert to fraction, add to H, and find modulus
Ih=mod(Ih+a./360,1);
%--------------------------------------------------------------------------
%convert to RGB
Ihsv=cat(3,Ih,Is,Iv);
Ic=hsv2rgb(Ihsv);
%--------------------------------------------------------------------------
%Modified the masked pixels
Ic2=I.*Im+Ic.*(1-Im);
%----------------------------------------------------------------------
%Display results
scrsz = get(0,'ScreenSize');
scrLeft=scrsz(1);
scrBottom=scrsz(2);
scrWidth=scrsz(3);
scrHeight=scrsz(4);

handle1=figure;    
set(handle1,'Position',[(100) (100) (scrWidth-200) (scrHeight-200)]);% Position: Left Bottom Width Height

subplot(1,3,1);
imshow(I); 
title('Original');

subplot(1,3,2);
imshow(Ic); 
title('Color modification'); 

subplot(1,3,3);
imshow(Ic2); 
title('Selective color modification'); 
%----------------------------------------------------------------------
imwrite(Ic2,'scc.jpg');